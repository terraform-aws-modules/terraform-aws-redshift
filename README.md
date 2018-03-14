AWS RDS Terraform module
========================

Terraform module which creates Redshift resources on AWS.

These types of resources are supported:

* [Redshift Cluster](https://www.terraform.io/docs/providers/aws/r/redshift_cluster.html)

Usage
-----

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"

  cluster_identifier      = "my-cluster"
  cluster_node_type       = "dc1.large"
  cluster_number_of_nodes = 3

  cluster_database_name   = "my-db"
  cluster_master_username = "mydbuser"
  cluster_master_password = "mydbpassword"

  # Group parameters
  wlm_json_configuration     = "${var.redshift_cluster_wlm_json_configuration}"

  # DB Subnet Group Inputs
  subnets         = ["subnet-123456", "subnet-654321"]
  redshift_vpc_id = "vpc-123456"
  private_cidr    = "10.0.20.0/20"

  # IAM Roles
  cluster_iam_roles = ["${var.redshift_role_arn}"]
}
```

Examples
--------

* [Complete Redshift cluster](https://github.com/terraform-aws-modules/terraform-aws-redshift/tree/master/examples/complete)

Authors
-------

Migrated from `terraform-community-modules/tf_aws_redshift`, where it was maintained by [these awesome contributors](https://github.com/terraform-community-modules/tf_aws_redshift/graphs/contributors).
Module managed by [Anton Babenko](https://github.com/antonbabenko).

License
-------

Apache 2 Licensed. See LICENSE for full details.
