data "aws_partition" "current" {}

resource "random_password" "master_password" {
  count = var.create && var.create_random_password ? 1 : 0

  length           = var.random_password_length
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

################################################################################
# Cluster
################################################################################

locals {
  subnet_group_name    = var.create && var.create_subnet_group ? aws_redshift_subnet_group.this[0].name : var.subnet_group_name
  parameter_group_name = var.create && var.create_parameter_group ? aws_redshift_parameter_group.this[0].id : var.parameter_group_name

  master_password = var.create && var.create_random_password ? random_password.master_password[0].result : var.master_password
}

resource "aws_redshift_cluster" "this" {
  count = var.create ? 1 : 0

  allow_version_upgrade                = var.allow_version_upgrade
  apply_immediately                    = var.apply_immediately
  aqua_configuration_status            = var.aqua_configuration_status
  automated_snapshot_retention_period  = var.automated_snapshot_retention_period
  availability_zone                    = var.availability_zone
  availability_zone_relocation_enabled = var.availability_zone_relocation_enabled
  cluster_identifier                   = var.cluster_identifier
  cluster_parameter_group_name         = local.parameter_group_name
  cluster_subnet_group_name            = local.subnet_group_name
  cluster_type                         = var.number_of_nodes > 1 ? "multi-node" : "single-node"
  cluster_version                      = var.cluster_version
  database_name                        = var.database_name
  elastic_ip                           = var.elastic_ip
  encrypted                            = var.encrypted
  enhanced_vpc_routing                 = var.enhanced_vpc_routing
  final_snapshot_identifier            = var.skip_final_snapshot ? null : var.final_snapshot_identifier
  kms_key_id                           = var.kms_key_arn

  # iam_roles and default_iam_roles are managed in the aws_redshift_cluster_iam_roles resource below

  dynamic "logging" {
    for_each = can(var.logging.enable) ? [var.logging] : []

    content {
      bucket_name          = try(logging.value.bucket_name, null)
      enable               = logging.value.enable
      log_destination_type = try(logging.value.log_destination_type, null)
      log_exports          = try(logging.value.log_exports, null)
      s3_key_prefix        = try(logging.value.s3_key_prefix, null)
    }
  }

  maintenance_track_name           = var.maintenance_track_name
  manual_snapshot_retention_period = var.manual_snapshot_retention_period
  master_password                  = var.snapshot_identifier != null ? null : local.master_password
  master_username                  = var.master_username
  node_type                        = var.node_type
  number_of_nodes                  = var.number_of_nodes
  owner_account                    = var.owner_account
  port                             = var.port
  preferred_maintenance_window     = var.preferred_maintenance_window
  publicly_accessible              = var.publicly_accessible
  skip_final_snapshot              = var.skip_final_snapshot
  snapshot_cluster_identifier      = var.snapshot_cluster_identifier

  dynamic "snapshot_copy" {
    for_each = length(var.snapshot_copy) > 0 ? [var.snapshot_copy] : []

    content {
      destination_region = snapshot_copy.value.destination_region
      grant_name         = try(snapshot_copy.value.grant_name, null)
      retention_period   = try(snapshot_copy.value.retention_period, null)
    }
  }

  snapshot_identifier    = var.snapshot_identifier
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = var.tags

  timeouts {
    create = try(var.cluster_timeouts.create, null)
    update = try(var.cluster_timeouts.update, null)
    delete = try(var.cluster_timeouts.delete, null)
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

################################################################################
# IAM Roles
################################################################################

resource "aws_redshift_cluster_iam_roles" "this" {
  count = var.create && length(var.iam_role_arns) > 0 ? 1 : 0

  cluster_identifier   = aws_redshift_cluster.this[0].id
  iam_role_arns        = var.iam_role_arns
  default_iam_role_arn = var.default_iam_role_arn
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
  description = try(each.value.description, null)
  enable      = try(each.value.enable, null)
  start_time  = try(each.value.start_time, null)
  end_time    = try(each.value.end_time, null)
  schedule    = each.value.schedule
  iam_role    = var.create_scheduled_action_iam_role ? aws_iam_role.scheduled_action[0].arn : each.value.iam_role

  target_action {
    dynamic "pause_cluster" {
      for_each = try([each.value.pause_cluster], [])

      content {
        cluster_identifier = aws_redshift_cluster.this[0].id
      }
    }

    dynamic "resize_cluster" {
      for_each = try([each.value.resize_cluster], [])

      content {
        classic            = try(resize_cluster.value.classic, null)
        cluster_identifier = aws_redshift_cluster.this[0].id
        cluster_type       = try(resize_cluster.value.cluster_type, null)
        node_type          = try(resize_cluster.value.node_type, null)
        number_of_nodes    = try(resize_cluster.value.number_of_nodes, null)
      }
    }

    dynamic "resume_cluster" {
      for_each = try([each.value.resume_cluster], [])

      content {
        cluster_identifier = aws_redshift_cluster.this[0].id
      }
    }
  }
}

data "aws_iam_policy_document" "scheduled_action_assume" {
  count = var.create && var.create_scheduled_action_iam_role ? 1 : 0

  statement {
    sid     = "ScheduleActionAssume"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["scheduler.redshift.${data.aws_partition.current.dns_suffix}"]
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
  assume_role_policy    = data.aws_iam_policy_document.scheduled_action_assume[0].json

  tags = merge(var.tags, var.iam_role_tags)
}

data "aws_iam_policy_document" "scheduled_action" {
  count = var.create && var.create_scheduled_action_iam_role ? 1 : 0

  statement {
    sid = "ModifyCluster"

    actions = [
      "redshift:PauseCluster",
      "redshift:ResumeCluster",
      "redshift:ResizeCluster",
    ]

    resources = [
      aws_redshift_cluster.this[0].arn
    ]
  }
}

resource "aws_iam_role_policy" "scheduled_action" {
  count = var.create && var.create_scheduled_action_iam_role ? 1 : 0

  name   = var.iam_role_name
  role   = aws_iam_role.scheduled_action[0].name
  policy = data.aws_iam_policy_document.scheduled_action[0].json
}

################################################################################
# Endpoint Access
################################################################################

resource "aws_redshift_endpoint_access" "this" {
  count = var.create && var.create_endpoint_access ? 1 : 0

  cluster_identifier = aws_redshift_cluster.this[0].id

  endpoint_name          = var.endpoint_name
  resource_owner         = var.endpoint_resource_owner
  subnet_group_name      = coalesce(var.endpoint_subnet_group_name, local.subnet_group_name)
  vpc_security_group_ids = var.endpoint_vpc_security_group_ids
}

################################################################################
# Usage Limit
################################################################################

resource "aws_redshift_usage_limit" "this" {
  for_each = { for k, v in var.usage_limits : k => v if var.create }

  cluster_identifier = aws_redshift_cluster.this[0].id

  amount        = each.value.amount
  breach_action = try(each.value.breach_action, null)
  feature_type  = each.value.feature_type
  limit_type    = each.value.limit_type
  period        = try(each.value.period, null)

  tags = merge(var.tags, try(each.value.tags, {}))
}

################################################################################
# Authentication Profile
################################################################################

resource "aws_redshift_authentication_profile" "this" {
  for_each = { for k, v in var.authentication_profiles : k => v if var.create }

  authentication_profile_name    = try(each.value.name, each.key)
  authentication_profile_content = jsonencode(each.value.content)
}
