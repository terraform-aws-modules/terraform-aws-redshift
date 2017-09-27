# tf_aws_redshift

Terraform module which creates a Redshift cluster on AWS

## Usage


```hcl
module "redshift" {
  source  = "github.com/terraform-community-modules/tf_aws_redshift"

  # Redshift Cluster Inputs
  cluster_identifier      = "${var.redshift_cluster_identifier}"
  cluster_node_type       = "${var.redshift_cluster_node_type}"
  cluster_number_of_nodes = "${var.redshift_cluster_number_of_nodes}"

  cluster_database_name   = "${var.redshift_cluster_database_name}"
  cluster_master_username = "${var.redshift_cluster_master_username}"
  cluster_master_password = "${var.redshift_cluster_master_password}"

  # Group parameters
  wlm_json_configuration     = "${var.redshift_cluster_wlm_json_configuration}"

  # DB Subnet Group Inputs
  subnets         = ["${var.public_subnets}"]
  redshift_vpc_id = "${var.vpc_id}"
  private_cidr    = "${var.vpc_cidr}"

  # IAM Roles
  cluster_iam_roles = ["${var.redshift_role_arn}"]
}
```

## Authors

Created and maintained by [Quentin Rousseau](https://github.com/kwent) (contact@quent.in).

## License

Apache 2 Licensed. See LICENSE for full details.
