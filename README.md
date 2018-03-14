AWS Redshift Terraform module
=============================

Terraform module which creates Redshift resources on AWS.

These types of resources are supported:

* [Redshift Cluster](https://www.terraform.io/docs/providers/aws/r/redshift_cluster.html)
* [Redshift parameter group](https://www.terraform.io/docs/providers/aws/r/redshift_parameter_group.html)
* [Redshift subnet group](https://www.terraform.io/docs/providers/aws/r/redshift_subnet_group.html)

Usage
-----

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"

  cluster_identifier      = "my-cluster"
  cluster_node_type       = "dc1.large"
  cluster_number_of_nodes = 1

  cluster_database_name   = "mydb"
  cluster_master_username = "mydbuser"
  cluster_master_password = "mySecretPassw0rd"

  # Group parameters
  wlm_json_configuration = "[{\"query_concurrency\": 5}]"

  # DB Subnet Group Inputs
  subnets = ["subnet-123456", "subnet-654321"]

  # IAM Roles
  cluster_iam_roles = ["arn:aws:iam::225367859851:role/developer"]
}
```

Examples
--------

* [Complete Redshift example](https://github.com/terraform-aws-modules/terraform-aws-redshift/tree/master/examples/complete) creates VPC with Redshift subnet, VPC security group and Redshift cluster itself.

Authors
-------

Migrated from `terraform-community-modules/tf_aws_redshift`, where it was originally created by [Quentin Rousseau](https://github.com/kwent) and maintained by [these awesome contributors](https://github.com/terraform-community-modules/tf_aws_redshift/graphs/contributors).
Module managed by [Anton Babenko](https://github.com/antonbabenko).

License
-------

Apache 2 Licensed. See LICENSE for full details.
