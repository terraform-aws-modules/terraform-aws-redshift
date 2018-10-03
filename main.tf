locals {
  redshift_subnet_group_name             = "${coalesce(var.redshift_subnet_group_name, element(concat(aws_redshift_subnet_group.this.*.name, list("")), 0))}"
  enable_create_redshift_subnet_group    = "${var.redshift_subnet_group_name == "" ? 1 : 0}"
}

resource "aws_redshift_cluster" "this" {
  cluster_identifier = "${var.cluster_identifier}"
  cluster_version    = "${var.cluster_version}"
  node_type          = "${var.cluster_node_type}"
  number_of_nodes    = "${var.cluster_number_of_nodes}"
  cluster_type       = "${var.cluster_number_of_nodes > 1 ? "multi-node" : "single-node" }"
  database_name      = "${var.cluster_database_name}"
  master_username    = "${var.cluster_master_username}"
  master_password    = "${var.cluster_master_password}"

  port = "${var.cluster_port}"

  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]

  cluster_subnet_group_name    = "${local.redshift_subnet_group_name}"
  cluster_parameter_group_name  = "${aws_redshift_parameter_group.this.id}"

  publicly_accessible = "${var.publicly_accessible}"

  # Snapshots and backups
  final_snapshot_identifier           = "${var.final_snapshot_identifier}"
  skip_final_snapshot                 = "${var.skip_final_snapshot}"
  automated_snapshot_retention_period = "${var.automated_snapshot_retention_period }"
  preferred_maintenance_window        = "${var.preferred_maintenance_window}"
  allow_version_upgrade               = "${var.allow_version_upgrade}"

  # IAM Roles
  iam_roles = ["${var.cluster_iam_roles}"]

  # Encryption
  encrypted  = "${var.encrypted}"
  kms_key_id = "${var.kms_key_id}"

  # Enhanced VPC routing
  enhanced_vpc_routing = "${var.enhanced_vpc_routing}"

  # Logging
  logging {
    enable        = "${var.enable_logging}"
    bucket_name   = "${var.logging_bucket_name}"
    s3_key_prefix = "${var.logging_s3_key_prefix}"
  }

  tags = "${var.tags}"
}

resource "aws_redshift_parameter_group" "this" {
  name   = "${replace(var.cluster_identifier, ".", "-")}-parameters"
  family = "${var.cluster_parameter_group}"

  parameter {
    name  = "wlm_json_configuration"
    value = "${var.wlm_json_configuration}"
  }

  parameter {
    # ref: https://docs.aws.amazon.com/redshift/latest/mgmt/connecting-ssl-support.html
    name  = "require_ssl"
    value = "${var.require_ssl}"
  }

  parameter {
    name  = "use_fips_ssl"
    value = "${var.use_fips_ssl}"
  }

  parameter {
    # ref: https://docs.aws.amazon.com/redshift/latest/mgmt/db-auditing.html
    name  = "enable_user_activity_logging"
    value = "${var.enable_user_activity_logging}"
  }

}

resource "aws_redshift_subnet_group" "this" {
  count = "${local.enable_create_redshift_subnet_group}"

  name        = "${var.cluster_identifier}"
  description = "Redshift subnet group of ${var.cluster_identifier}"
  subnet_ids  = ["${var.subnets}"]

  tags = "${var.tags}"
}
