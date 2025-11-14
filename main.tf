################################################################################
# Cluster
################################################################################

locals {
  subnet_group_name    = var.create && var.create_subnet_group ? aws_redshift_subnet_group.this[0].name : var.subnet_group_name
  parameter_group_name = var.create && var.create_parameter_group ? aws_redshift_parameter_group.this[0].id : var.parameter_group_name
}

resource "aws_redshift_cluster" "this" {
  count = var.create ? 1 : 0

  region = var.region

  allow_version_upgrade                = var.allow_version_upgrade
  apply_immediately                    = var.apply_immediately
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

  maintenance_track_name            = var.maintenance_track_name
  manual_snapshot_retention_period  = var.manual_snapshot_retention_period
  manage_master_password            = var.manage_master_password ? var.manage_master_password : null
  master_password                   = var.snapshot_identifier == null && !var.manage_master_password ? var.master_password : null
  master_password_secret_kms_key_id = var.master_password_secret_kms_key_id
  master_username                   = var.master_username
  multi_az                          = var.multi_az
  node_type                         = var.node_type
  number_of_nodes                   = var.number_of_nodes
  owner_account                     = var.owner_account
  port                              = var.port
  preferred_maintenance_window      = var.preferred_maintenance_window
  publicly_accessible               = var.publicly_accessible
  skip_final_snapshot               = var.skip_final_snapshot
  snapshot_cluster_identifier       = var.snapshot_cluster_identifier

  snapshot_identifier    = var.snapshot_identifier
  vpc_security_group_ids = compact(concat(aws_security_group.this[*].id, var.vpc_security_group_ids))

  tags = var.tags

  dynamic "timeouts" {
    for_each = var.cluster_timeouts != null ? [1] : []

    content {
      create = var.cluster_timeouts.create
      update = var.cluster_timeouts.update
      delete = var.cluster_timeouts.delete
    }
  }

  lifecycle {
    ignore_changes = [master_password]
  }

  depends_on = [aws_cloudwatch_log_group.this]
}

################################################################################
# IAM Roles
################################################################################

resource "aws_redshift_cluster_iam_roles" "this" {
  count = var.create && length(var.iam_role_arns) > 0 ? 1 : 0

  region = var.region

  cluster_identifier   = aws_redshift_cluster.this[0].id
  iam_role_arns        = var.iam_role_arns
  default_iam_role_arn = var.default_iam_role_arn
}

################################################################################
# Parameter Group
################################################################################

resource "aws_redshift_parameter_group" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  region = var.region

  name        = coalesce(var.parameter_group_name, replace(var.cluster_identifier, ".", "-"))
  description = var.parameter_group_description
  family      = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameter_group_parameters != null ? var.parameter_group_parameters : []

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

  region = var.region

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

  region = var.region

  identifier        = var.use_snapshot_identifier_prefix ? null : var.snapshot_schedule_identifier
  identifier_prefix = var.use_snapshot_identifier_prefix ? "${var.snapshot_schedule_identifier}-" : null
  description       = var.snapshot_schedule_description
  definitions       = var.snapshot_schedule_definitions
  force_destroy     = var.snapshot_schedule_force_destroy

  tags = var.tags
}

resource "aws_redshift_snapshot_schedule_association" "this" {
  count = var.create && var.create_snapshot_schedule ? 1 : 0

  region = var.region

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

  region = var.region

  name        = try(coalesce(each.value.name, each.key))
  description = each.value.description
  enable      = each.value.enable
  start_time  = each.value.start_time
  end_time    = each.value.end_time
  schedule    = each.value.schedule
  iam_role    = var.create_scheduled_action_iam_role ? aws_iam_role.scheduled_action[0].arn : each.value.iam_role

  dynamic "target_action" {
    for_each = [each.value.target_action]

    content {
      dynamic "pause_cluster" {
        for_each = each.value.pause_cluster != null ? [each.value.pause_cluster] : []

        content {
          cluster_identifier = aws_redshift_cluster.this[0].id
        }
      }

      dynamic "resize_cluster" {
        for_each = each.value.resize_cluster != null ? [each.value.resize_cluster] : []

        content {
          classic            = resize_cluster.value.classic
          cluster_identifier = aws_redshift_cluster.this[0].id
          cluster_type       = resize_cluster.value.cluster_type
          node_type          = resize_cluster.value.node_type
          number_of_nodes    = resize_cluster.value.number_of_nodes
        }
      }

      dynamic "resume_cluster" {
        for_each = each.value.resume_cluster != null ? [each.value.resume_cluster] : []

        content {
          cluster_identifier = aws_redshift_cluster.this[0].id
        }
      }
    }
  }
}

################################################################################
# Scheduled Action IAM Role
################################################################################

data "aws_service_principal" "scheduler_redshift" {
  count = var.create && var.create_scheduled_action_iam_role ? 1 : 0

  service_name = "scheduler.redshift"
}

data "aws_iam_policy_document" "scheduled_action_assume" {
  count = var.create && var.create_scheduled_action_iam_role ? 1 : 0

  statement {
    sid     = "ScheduleActionAssume"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [data.aws_service_principal.scheduler_redshift[0].name]
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
  for_each = var.create && var.endpoint_access != null ? var.endpoint_access : {}

  region = var.region

  cluster_identifier     = aws_redshift_cluster.this[0].id
  endpoint_name          = try(coalesce(each.value.name, each.key))
  resource_owner         = each.value.resource_owner
  subnet_group_name      = each.value.subnet_group_name
  vpc_security_group_ids = each.value.vpc_security_group_ids
}

################################################################################
# Usage Limit
################################################################################

resource "aws_redshift_usage_limit" "this" {
  for_each = { for k, v in var.usage_limits : k => v if var.create }

  region = var.region

  amount             = each.value.amount
  breach_action      = each.value.breach_action
  cluster_identifier = aws_redshift_cluster.this[0].id
  feature_type       = each.value.feature_type
  limit_type         = try(coalesce(each.value.limit_type))
  period             = each.value.period

  tags = merge(var.tags, each.value.tags)
}

################################################################################
# Authentication Profile
################################################################################

resource "aws_redshift_authentication_profile" "this" {
  for_each = { for k, v in var.authentication_profiles : k => v if var.create }

  region = var.region

  authentication_profile_name    = try(each.value.name, each.key)
  authentication_profile_content = jsonencode(each.value.content)
}

################################################################################
# Logging
################################################################################

resource "aws_redshift_logging" "this" {
  count = var.create && var.logging != null ? 1 : 0

  region = var.region

  cluster_identifier   = aws_redshift_cluster.this[0].id
  bucket_name          = var.logging.bucket_name
  log_destination_type = var.logging.log_destination_type
  log_exports          = var.logging.log_exports
  s3_key_prefix        = var.logging.s3_key_prefix
}

################################################################################
# Snapshot Copy
################################################################################

resource "aws_redshift_snapshot_copy" "this" {
  count = var.create && var.snapshot_copy != null ? 1 : 0

  region = var.region

  cluster_identifier               = aws_redshift_cluster.this[0].id
  destination_region               = var.snapshot_copy.destination_region
  manual_snapshot_retention_period = var.snapshot_copy.manual_snapshot_retention_period
  retention_period                 = var.snapshot_copy.retention_period
  snapshot_copy_grant_name         = var.snapshot_copy.grant_name
}

################################################################################
# CloudWatch Log Group
################################################################################

resource "aws_cloudwatch_log_group" "this" {
  for_each = toset([for log in try(var.logging.log_exports, []) : log if var.create && var.create_cloudwatch_log_group])

  region = var.region

  name              = "/aws/redshift/cluster/${var.cluster_identifier}/${each.value}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id
  skip_destroy      = var.cloudwatch_log_group_skip_destroy

  tags = merge(var.tags, var.cloudwatch_log_group_tags)
}

################################################################################
# Managed Secret Rotation
################################################################################

resource "aws_secretsmanager_secret_rotation" "this" {
  count = var.create && var.manage_master_password && var.manage_master_password_rotation ? 1 : 0

  region = var.region

  secret_id          = aws_redshift_cluster.this[0].master_password_secret_arn
  rotate_immediately = var.master_password_rotate_immediately

  rotation_rules {
    automatically_after_days = var.master_password_rotation_automatically_after_days
    duration                 = var.master_password_rotation_duration
    schedule_expression      = var.master_password_rotation_schedule_expression
  }
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = var.create && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.cluster_identifier), "")
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  region = var.region

  name        = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
  vpc_id      = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from Redshift cluster ${var.security_group_name}")

  tags = merge(
    var.tags,
    var.security_group_tags,
    { "Name" = local.security_group_name }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for k, v in var.security_group_ingress_rules : k => v if var.security_group_ingress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = try(coalesce(each.value.from_port, var.port), null)
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id == "self" ? aws_security_group.this[0].id : each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}") },
    each.value.tags
  )
  to_port = try(coalesce(each.value.to_port, each.value.from_port, var.port), null)
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for k, v in var.security_group_egress_rules : k => v if var.security_group_egress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = try(coalesce(each.value.from_port, each.value.to_port, var.port), null)
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id == "self" ? aws_security_group.this[0].id : each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}") },
    each.value.tags
  )
  to_port = try(coalesce(each.value.to_port, var.port), null)
}
