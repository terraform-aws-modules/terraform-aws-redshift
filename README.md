# AWS Redshift Terraform module

Terraform module which creates Redshift resources on AWS.

These types of resources are supported:

* [Redshift Cluster](https://www.terraform.io/docs/providers/aws/r/redshift_cluster.html)
* [Redshift parameter group](https://www.terraform.io/docs/providers/aws/r/redshift_parameter_group.html)
* [Redshift subnet group](https://www.terraform.io/docs/providers/aws/r/redshift_subnet_group.html)

## Terraform versions

Terraform 0.12. Pin module version to `~> v2.0`. Submit pull-requests to `master` branch.

Terraform 0.11. Pin module version to `~> v1.0`. Submit pull-requests to `terraform011` branch.

## Usage

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 2.0"

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
| allow\_version\_upgrade | (Optional) If true, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. | bool | `"true"` | no |
| automated\_snapshot\_retention\_period | How long will we retain backups | number | `"0"` | no |
| cluster\_database\_name | The name of the database to create | string | n/a | yes |
| cluster\_iam\_roles | A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time. | list(string) | `[]` | no |
| cluster\_identifier | Custom name of the cluster | string | n/a | yes |
| cluster\_master\_password | Password for master user | string | n/a | yes |
| cluster\_master\_username | Master username | string | n/a | yes |
| cluster\_node\_type | Node Type of Redshift cluster | string | n/a | yes |
| cluster\_number\_of\_nodes | Number of nodes in the cluster (values greater than 1 will trigger 'cluster_type' of 'multi-node') | number | `"3"` | no |
| cluster\_parameter\_group | Parameter group, depends on DB engine used | string | `"redshift-1.0"` | no |
| cluster\_port |  | number | `"5439"` | no |
| cluster\_version | Version of Redshift engine cluster | string | `"1.0"` | no |
| enable\_logging | Enables logging information such as queries and connection attempts, for the specified Amazon Redshift cluster. | bool | `"false"` | no |
| enable\_user\_activity\_logging | Enable logging of user activity. See https://docs.aws.amazon.com/redshift/latest/mgmt/db-auditing.html | string | `"false"` | no |
| encrypted | (Optional) If true , the data in the cluster is encrypted at rest. | bool | `"false"` | no |
| enhanced\_vpc\_routing | (Optional) If true, enhanced VPC routing is enabled. | bool | `"false"` | no |
| final\_snapshot\_identifier | (Optional) The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, 'skip_final_snapshot' must be false. | bool | `"false"` | no |
| kms\_key\_id | (Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true. | string | `""` | no |
| logging\_bucket\_name | (Optional, required when enable_logging is true) The name of an existing S3 bucket where the log files are to be stored. Must be in the same region as the cluster and the cluster must have read bucket and put object permissions. | string | `"null"` | no |
| logging\_s3\_key\_prefix | (Optional) The prefix applied to the log file names. | string | `"null"` | no |
| parameter\_group\_name | The name of the parameter group to be associated with this cluster. If not specified new parameter group will be created. | string | `""` | no |
| preferred\_maintenance\_window | When AWS can run snapshot, can't overlap with maintenance window | string | `"sat:10:00-sat:10:30"` | no |
| publicly\_accessible | Determines if Cluster can be publicly available (NOT recommended) | bool | `"false"` | no |
| redshift\_subnet\_group\_name | The name of a cluster subnet group to be associated with this cluster. If not specified, new subnet will be created. | string | `""` | no |
| require\_ssl | Require SSL to connect to this cluster | string | `"false"` | no |
| skip\_final\_snapshot | If true (default), no snapshot will be made before deleting DB | bool | `"true"` | no |
| snapshot\_cluster\_identifier | (Optional) The name of the cluster the source snapshot was created from. | string | `"null"` | no |
| snapshot\_identifier | (Optional) The name of the snapshot from which to create the new cluster. | string | `"null"` | no |
| subnets | List of subnets DB should be available at. It might be one subnet. | list(string) | `[]` | no |
| tags | A mapping of tags to assign to all resources | map(string) | `{}` | no |
| use\_fips\_ssl | Enable FIPS-compliant SSL mode only if your system is required to be FIPS compliant. | string | `"false"` | no |
| vpc\_security\_group\_ids | A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster. | list(string) | n/a | yes |
| wlm\_json\_configuration | Configuration bits for WLM json. see https://docs.aws.amazon.com/redshift/latest/mgmt/workload-mgmt-config.html | string | `"[{\"query_concurrency\": 5}]"` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_redshift\_cluster\_arn | The Redshift cluster ARN |
| this\_redshift\_cluster\_automated\_snapshot\_retention\_period | The backup retention period |
| this\_redshift\_cluster\_availability\_zone | The availability zone of the Cluster |
| this\_redshift\_cluster\_database\_name | The name of the default database in the Cluster |
| this\_redshift\_cluster\_encrypted | Whether the data in the cluster is encrypted |
| this\_redshift\_cluster\_endpoint | The connection endpoint |
| this\_redshift\_cluster\_hostname | The hostname of the Redshift cluster |
| this\_redshift\_cluster\_id | The Redshift cluster ID |
| this\_redshift\_cluster\_identifier | The Redshift cluster identifier |
| this\_redshift\_cluster\_node\_type | The type of nodes in the cluster |
| this\_redshift\_cluster\_parameter\_group\_name | The name of the parameter group to be associated with this cluster |
| this\_redshift\_cluster\_port | The port the cluster responds on |
| this\_redshift\_cluster\_preferred\_maintenance\_window | The backup window |
| this\_redshift\_cluster\_public\_key | The public key for the cluster |
| this\_redshift\_cluster\_revision\_number | The specific revision number of the database in the cluster |
| this\_redshift\_cluster\_security\_groups | The security groups associated with the cluster |
| this\_redshift\_cluster\_subnet\_group\_name | The name of a cluster subnet group to be associated with this cluster |
| this\_redshift\_cluster\_type | The Redshift cluster type |
| this\_redshift\_cluster\_version | The version of Redshift engine software |
| this\_redshift\_cluster\_vpc\_security\_group\_ids | The VPC security group ids associated with the cluster |
| this\_redshift\_parameter\_group\_id | The ID of Redshift parameter group created by this module |
| this\_redshift\_subnet\_group\_id | The ID of Redshift subnet group created by this module |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Migrated from `terraform-community-modules/tf_aws_redshift`, where it was originally created by [Quentin Rousseau](https://github.com/kwent) and maintained by [these awesome contributors](https://github.com/terraform-community-modules/tf_aws_redshift/graphs/contributors).
Module managed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
