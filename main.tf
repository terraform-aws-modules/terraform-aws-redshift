locals {
  # if passed a value for redshift_subnet_group_name, we'll use that instead of creating a subnet group
  redshift_subnet_group_name = coalesce(
    var.redshift_subnet_group_name,
    element(concat(aws_redshift_subnet_group.this.*.name, [""]), 0),
  )

  # if we were passed a value for parameter_group_name, we'll use that instead of creating a parameter group name
  parameter_group_name = coalesce(
    var.parameter_group_name,
    element(concat(aws_redshift_parameter_group.this.*.id, [""]), 0),
  )
}

resource "aws_redshift_cluster" "this" {
  cluster_identifier = var.cluster_identifier
  cluster_version    = var.cluster_version
  node_type          = var.cluster_node_type
  number_of_nodes    = var.cluster_number_of_nodes
  cluster_type       = var.cluster_number_of_nodes > 1 ? "multi-node" : "single-node"
  database_name      = var.cluster_database_name
  master_username    = var.cluster_master_username
  master_password    = var.cluster_master_password

  port = var.cluster_port

  vpc_security_group_ids = var.vpc_security_group_ids

  cluster_subnet_group_name    = local.redshift_subnet_group_name
  cluster_parameter_group_name = local.parameter_group_name

  publicly_accessible = var.publicly_accessible

  # Restore from snapshot
  snapshot_identifier         = var.snapshot_identifier
  snapshot_cluster_identifier = var.snapshot_cluster_identifier
  owner_account               = var.owner_account

  # Snapshots and backups
  final_snapshot_identifier           = var.final_snapshot_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  automated_snapshot_retention_period = var.automated_snapshot_retention_period
  preferred_maintenance_window        = var.preferred_maintenance_window
  allow_version_upgrade               = var.allow_version_upgrade

  # Snapshots copy to another region
  dynamic "snapshot_copy" {
    for_each = compact([var.snapshot_copy_destination_region])
    content {
      destination_region = var.snapshot_copy_destination_region
      retention_period   = var.automated_snapshot_retention_period
    }
  }

  # IAM Roles
  iam_roles = var.cluster_iam_roles

  # Encryption
  encrypted  = var.encrypted
  kms_key_id = var.kms_key_id

  # Enhanced VPC routing
  enhanced_vpc_routing = var.enhanced_vpc_routing

  # Logging
  logging {
    enable        = var.enable_logging
    bucket_name   = var.logging_bucket_name
    s3_key_prefix = var.logging_s3_key_prefix
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_parameter_group" "this" {
  # if we were passed a value for parameter_group_name, don't bother creating a parameter group
  count  = length(var.parameter_group_name) > 0 ? 0 : 1
  name   = "${var.cluster_identifier}-${replace(var.cluster_parameter_group, ".", "-")}-custom-params"
  family = var.cluster_parameter_group

  parameter {
    name  = "wlm_json_configuration"
    value = var.wlm_json_configuration
  }

  parameter {
    # ref: https://docs.aws.amazon.com/redshift/latest/mgmt/connecting-ssl-support.html
    name  = "require_ssl"
    value = var.require_ssl
  }

  parameter {
    name  = "use_fips_ssl"
    value = var.use_fips_ssl
  }

  parameter {
    # ref: https://docs.aws.amazon.com/redshift/latest/mgmt/db-auditing.html
    name  = "enable_user_activity_logging"
    value = var.enable_user_activity_logging
  }

  parameter {
    # ref: https://docs.aws.amazon.com/redshift/latest/dg/concurrency-scaling.html
    name  = "max_concurrency_scaling_clusters"
    value = var.max_concurrency_scaling_clusters
  }

  parameter {
    # ref: https://docs.aws.amazon.com/redshift/latest/dg/r_enable_case_sensitive_identifier.html
    name  = "enable_case_sensitive_identifier"
    value = var.enable_case_sensitive_identifier
  }

  tags = var.tags
}

resource "aws_redshift_subnet_group" "this" {
  count = var.redshift_subnet_group_name == "" ? 1 : 0

  name        = var.cluster_identifier
  description = "Redshift subnet group of ${var.cluster_identifier}"
  subnet_ids  = var.subnets

  tags = var.tags
}
