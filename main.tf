locals {
  subnet_group_name    = var.create && var.create_subnet_group ? aws_redshift_subnet_group.this[0].name : var.subnet_group_name
  parameter_group_name = var.create && var.create_parameter_group ? aws_redshift_parameter_group.this[0].id : var.parameter_group_name
}

resource "aws_redshift_cluster" "this" {
  count = var.create ? 1 : 0

  cluster_identifier           = var.cluster_identifier
  cluster_version              = var.cluster_version
  allow_version_upgrade        = var.allow_version_upgrade
  cluster_type                 = var.number_of_nodes > 1 ? "multi-node" : "single-node"
  cluster_subnet_group_name    = local.subnet_group_name
  cluster_parameter_group_name = local.parameter_group_name

  node_type       = var.node_type
  number_of_nodes = var.number_of_nodes
  port            = var.port

  database_name   = var.database_name
  master_username = var.snapshot_identifier != null ? null : var.master_username
  master_password = var.snapshot_identifier != null ? null : var.master_password

  iam_roles  = var.iam_roles
  encrypted  = var.encrypted
  kms_key_id = var.kms_key_arn

  enhanced_vpc_routing                 = var.enhanced_vpc_routing
  cluster_security_groups              = var.cluster_security_groups
  vpc_security_group_ids               = var.vpc_security_group_ids
  publicly_accessible                  = var.publicly_accessible
  elastic_ip                           = var.elastic_ip
  availability_zone                    = var.availability_zone
  availability_zone_relocation_enabled = var.availability_zone_relocation_enabled

  owner_account                       = var.owner_account
  snapshot_identifier                 = var.snapshot_identifier
  snapshot_cluster_identifier         = var.snapshot_cluster_identifier
  final_snapshot_identifier           = var.skip_final_snapshot ? null : var.final_snapshot_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  automated_snapshot_retention_period = var.automated_snapshot_retention_period
  preferred_maintenance_window        = var.preferred_maintenance_window

  dynamic "snapshot_copy" {
    for_each = var.snapshot_copy
    content {
      destination_region = snapshot_copy.value.destination_region
      retention_period   = lookup(snapshot_copy.value, "retention_period", null)
      grant_name         = lookup(snapshot_copy.value, "grant_name", null)
    }
  }

  dynamic "logging" {
    for_each = can(var.logging.enable) ? [var.logging] : []
    content {
      enable        = logging.value.enable
      bucket_name   = logging.value.bucket_name
      s3_key_prefix = lookup(logging.value, "s3_key_prefix", null)
    }
  }

  timeouts {
    create = lookup(var.cluster_timeouts, "create", null)
    update = lookup(var.cluster_timeouts, "update", null)
    delete = lookup(var.cluster_timeouts, "delete", null)
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [master_password]
  }
}

################################################################################
# Parameter Group
################################################################################

resource "aws_redshift_parameter_group" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  name        = coalesce(var.parameter_group_name, replace(var.cluster_identifier, ".", "-"))
  description = var.parameter_group_description
  family      = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameter_group_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = merge(var.tags, var.parameter_group_tags)
}

################################################################################
# Subnet Group
################################################################################

resource "aws_redshift_subnet_group" "this" {
  count = var.create && var.create_subnet_group ? 1 : 0

  name        = coalesce(var.subnet_group_name, var.cluster_identifier)
  description = var.subnet_group_description
  subnet_ids  = var.subnet_ids

  tags = merge(var.tags, var.subnet_group_tags)
}

################################################################################
# Snapshot Schedule
################################################################################

resource "aws_redshift_snapshot_schedule" "this" {
  count = var.create && var.create_snapshot_schedule ? 1 : 0

  identifier        = var.use_snapshot_identifier_prefix ? null : var.snapshot_schedule_identifier
  identifier_prefix = var.use_snapshot_identifier_prefix ? "${var.snapshot_schedule_identifier}-" : null
  description       = var.snapshot_schedule_description
  definitions       = var.snapshot_schedule_definitions
  force_destroy     = var.snapshot_schedule_force_destroy

  tags = var.tags
}

resource "aws_redshift_snapshot_schedule_association" "this" {
  count = var.create && var.create_snapshot_schedule ? 1 : 0

  cluster_identifier  = aws_redshift_cluster.this[0].id
  schedule_identifier = aws_redshift_snapshot_schedule.this[0].id
}

################################################################################
# Scheduled Action
################################################################################

locals {
  iam_role_name = coalesce(var.iam_role_name, "${var.cluster_identifier}-scheduled-action")
}

resource "aws_redshift_scheduled_action" "this" {
  for_each = { for k, v in var.scheduled_actions : k => v if var.create }

  name        = each.value.name
  description = lookup(each.value, "description", null)
  enable      = lookup(each.value, "enable", null)
  start_time  = lookup(each.value, "start_time", null)
  end_time    = lookup(each.value, "end_time", null)
  schedule    = each.value.schedule
  iam_role    = try(aws_iam_role.scheduled_action[0].arn, each.value.iam_role)

  target_action {
    dynamic "pause_cluster" {
      for_each = can(each.value.pause_cluster) ? [each.value.pause_cluster] : []
      content {
        cluster_identifier = aws_redshift_cluster.this[0].id
      }
    }

    dynamic "resize_cluster" {
      for_each = can(each.value.resize_cluster) ? [each.value.resize_cluster] : []
      content {
        cluster_identifier = aws_redshift_cluster.this[0].id
        classic            = lookup(resize_cluster.value, "classic", null)
        cluster_type       = lookup(resize_cluster.value, "cluster_type", null)
        node_type          = lookup(resize_cluster.value, "node_type", null)
        number_of_nodes    = lookup(resize_cluster.value, "number_of_nodes", null)
      }
    }

    dynamic "resume_cluster" {
      for_each = can(each.value.resume_cluster) ? [each.value.resume_cluster] : []
      content {
        cluster_identifier = aws_redshift_cluster.this[0].id
      }
    }
  }
}

resource "aws_iam_role" "scheduled_action" {
  count = var.create && var.create_scheduled_action_iam_role ? 1 : 0

  name        = var.iam_role_use_name_prefix ? null : local.iam_role_name
  name_prefix = var.iam_role_use_name_prefix ? "${local.iam_role_name}-" : null
  path        = var.iam_role_path
  description = var.iam_role_description

  permissions_boundary  = var.iam_role_permissions_boundary
  force_detach_policies = true

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid    = "ScheduleActionAssume"
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = ["scheduler.redshift.amazonaws.com"]
      }
    }]
  })

  inline_policy {
    name = var.iam_role_name
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Sid    = "ModifyCluster"
        Effect = "Allow"
        Action = [
          "redshift:PauseCluster",
          "redshift:ResumeCluster",
          "redshift:ResizeCluster"
        ],
        Resource = aws_redshift_cluster.this[0].arn
      }]
    })
  }

  tags = merge(var.tags, var.iam_role_tags)
}
