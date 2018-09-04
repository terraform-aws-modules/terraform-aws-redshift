# AWS Redshift Terraform module

Terraform module which creates Redshift resources on AWS.

These types of resources are supported:

* [Redshift Cluster](https://www.terraform.io/docs/providers/aws/r/redshift_cluster.html)
* [Redshift parameter group](https://www.terraform.io/docs/providers/aws/r/redshift_parameter_group.html)
* [Redshift subnet group](https://www.terraform.io/docs/providers/aws/r/redshift_subnet_group.html)

## Usage

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

## Examples

* [Complete Redshift example](https://github.com/terraform-aws-modules/terraform-aws-redshift/tree/master/examples/complete) creates VPC with Redshift subnet, VPC security group and Redshift cluster itself.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allow_version_upgrade | (Optional) If true, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. | string | `true` | no |
| automated_snapshot_retention_period | How long will we retain backups | string | `0` | no |
| cluster_database_name | The name of the database to create | string | - | yes |
| cluster_iam_roles | A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time. | list | `<list>` | no |
| cluster_identifier | Custom name of the cluster | string | - | yes |
| cluster_master_password |  | string | - | yes |
| cluster_master_username | Self-explainatory variables | string | - | yes |
| cluster_node_type | Node Type of Redshift cluster | string | - | yes |
| cluster_number_of_nodes | Number of nodes in the cluster (values greater than 1 will trigger 'cluster_type' of 'multi-node') | string | `3` | no |
| cluster_parameter_group | Parameter group, depends on DB engine used | string | `redshift-1.0` | no |
| cluster_port |  | string | `5439` | no |
| cluster_version | Version of Redshift engine cluster | string | `1.0` | no |
| enable_logging | Enables logging information such as queries and connection attempts, for the specified Amazon Redshift cluster. | string | `false` | no |
| encrypted | (Optional) If true , the data in the cluster is encrypted at rest. | string | `false` | no |
| enhanced_vpc_routing | (Optional) If true, enhanced VPC routing is enabled. | string | `false` | no |
| final_snapshot_identifier | (Optional) The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, 'skip_final_snapshot' must be false. | string | `false` | no |
| kms_key_id | (Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true. | string | `` | no |
| logging_bucket_name | (Optional, required when enable_logging is true) The name of an existing S3 bucket where the log files are to be stored. Must be in the same region as the cluster and the cluster must have read bucket and put object permissions. | string | `false` | no |
| logging_s3_key_prefix | (Optional) The prefix applied to the log file names. | string | `false` | no |
| parameter_group_name | The name of the parameter group to be associated with this cluster. If not specified new parameter group will be created. | string | `` | no |
| preferred_maintenance_window | When AWS can run snapshot, can't overlap with maintenance window | string | `sat:10:00-sat:10:30` | no |
| publicly_accessible | Determines if Cluster can be publicly available (NOT recommended) | string | `false` | no |
| redshift_subnet_group_name | The name of a cluster subnet group to be associated with this cluster. If not specified, new subnet will be created. | string | `` | no |
| skip_final_snapshot | If true (default), no snapshot will be made before deleting DB | string | `true` | no |
| subnets | List of subnets DB should be available at. It might be one subnet. | string | `<list>` | no |
| tags | A mapping of tags to assign to all resources | string | `<map>` | no |
| vpc_security_group_ids | A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster. | list | - | yes |
| wlm_json_configuration |  | string | `[{"query_concurrency": 5}]` | no |

## Outputs

| Name | Description |
|------|-------------|
| this_redshift_cluster_automated_snapshot_retention_period | The backup retention period |
| this_redshift_cluster_availability_zone | The availability zone of the Cluster |
| this_redshift_cluster_database_name | The name of the default database in the Cluster |
| this_redshift_cluster_encrypted | Whether the data in the cluster is encrypted |
| this_redshift_cluster_endpoint | The connection endpoint |
| this_redshift_cluster_hostname | The hostname of the Redshift cluster |
| this_redshift_cluster_id | The Redshift cluster ID |
| this_redshift_cluster_identifier | The Redshift cluster identifier |
| this_redshift_cluster_node_type | The type of nodes in the cluster |
| this_redshift_cluster_parameter_group_name | The name of the parameter group to be associated with this cluster |
| this_redshift_cluster_port | The port the cluster responds on |
| this_redshift_cluster_preferred_maintenance_window | The backup window |
| this_redshift_cluster_public_key | The public key for the cluster |
| this_redshift_cluster_revision_number | The specific revision number of the database in the cluster |
| this_redshift_cluster_security_groups | The security groups associated with the cluster |
| this_redshift_cluster_subnet_group_name | The name of a cluster subnet group to be associated with this cluster |
| this_redshift_cluster_type | The Redshift cluster type |
| this_redshift_cluster_version | The version of Redshift engine software |
| this_redshift_cluster_vpc_security_group_ids | The VPC security group ids associated with the cluster |
| this_redshift_parameter_group_id | The ID of Redshift parameter group created by this module |
| this_redshift_subnet_group_id | The ID of Redshift subnet group created by this module |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Migrated from `terraform-community-modules/tf_aws_redshift`, where it was originally created by [Quentin Rousseau](https://github.com/kwent) and maintained by [these awesome contributors](https://github.com/terraform-community-modules/tf_aws_redshift/graphs/contributors).
Module managed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
