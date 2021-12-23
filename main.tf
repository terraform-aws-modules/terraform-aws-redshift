
resource "random_password" "master_password" {
  count = var.create && var.create_random_password ? 1 : 0

  length      = var.random_password_length
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  special     = false
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
  master_password = var.snapshot_identifier != null ? null : local.master_password

  iam_roles  = var.iam_roles
  encrypted  = var.encrypted
  kms_key_id = var.kms_key_id

  enhanced_vpc_routing    = var.enhanced_vpc_routing
  cluster_security_groups = var.cluster_security_groups
  vpc_security_group_ids  = var.vpc_security_group_ids
  publicly_accessible     = var.publicly_accessible
  elastic_ip              = var.elastic_ip
  availability_zone       = var.availability_zone

  owner_account                       = var.owner_account
  snapshot_identifier                 = var.snapshot_identifier
  snapshot_cluster_identifier         = var.snapshot_cluster_identifier
  final_snapshot_identifier           = var.skip_final_snapshot ? null : var.final_snapshot_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  automated_snapshot_retention_period = var.automated_snapshot_retention_period
  preferred_maintenance_window        = var.preferred_maintenance_window

  dynamic "snapshot_copy" {
    for_each = can(var.snapshot_copy.destination_region) ? [var.snapshot_copy] : []
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
# Paramter Group
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
