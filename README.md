# AWS Redshift Terraform module

Terraform module which creates Redshift resources on AWS.

## Usage

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 3.0"

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

- [Complete Redshift example](https://github.com/terraform-aws-modules/terraform-aws-redshift/tree/master/examples/complete) creates VPC with Redshift subnet, VPC security group and Redshift cluster itself.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_redshift_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster) | resource |
| [aws_redshift_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_parameter_group) | resource |
| [aws_redshift_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_version_upgrade"></a> [allow\_version\_upgrade](#input\_allow\_version\_upgrade) | (Optional) If true, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. | `bool` | `true` | no |
| <a name="input_automated_snapshot_retention_period"></a> [automated\_snapshot\_retention\_period](#input\_automated\_snapshot\_retention\_period) | How long will we retain backups | `number` | `0` | no |
| <a name="input_cluster_database_name"></a> [cluster\_database\_name](#input\_cluster\_database\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_cluster_iam_roles"></a> [cluster\_iam\_roles](#input\_cluster\_iam\_roles) | A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time. | `list(string)` | `[]` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | Custom name of the cluster | `string` | n/a | yes |
| <a name="input_cluster_master_password"></a> [cluster\_master\_password](#input\_cluster\_master\_password) | Password for master user | `string` | n/a | yes |
| <a name="input_cluster_master_username"></a> [cluster\_master\_username](#input\_cluster\_master\_username) | Master username | `string` | n/a | yes |
| <a name="input_cluster_node_type"></a> [cluster\_node\_type](#input\_cluster\_node\_type) | Node Type of Redshift cluster | `string` | n/a | yes |
| <a name="input_cluster_number_of_nodes"></a> [cluster\_number\_of\_nodes](#input\_cluster\_number\_of\_nodes) | Number of nodes in the cluster (values greater than 1 will trigger 'cluster\_type' of 'multi-node') | `number` | `3` | no |
| <a name="input_cluster_parameter_group"></a> [cluster\_parameter\_group](#input\_cluster\_parameter\_group) | Parameter group, depends on DB engine used | `string` | `"redshift-1.0"` | no |
| <a name="input_cluster_port"></a> [cluster\_port](#input\_cluster\_port) | Cluster port | `number` | `5439` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of Redshift engine cluster | `string` | `"1.0"` | no |
| <a name="input_elastic_ip"></a> [elastic\_ip](#input\_elastic\_ip) | (Optional) The Elastic IP (EIP) address for the cluster. | `string` | `null` | no |
| <a name="input_enable_case_sensitive_identifier"></a> [enable\_case\_sensitive\_identifier](#input\_enable\_case\_sensitive\_identifier) | (Optional) A configuration value that determines whether name identifiers of databases, tables, and columns are case sensitive. | `bool` | `false` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Enables logging information such as queries and connection attempts, for the specified Amazon Redshift cluster. | `bool` | `false` | no |
| <a name="input_enable_user_activity_logging"></a> [enable\_user\_activity\_logging](#input\_enable\_user\_activity\_logging) | Enable logging of user activity. See https://docs.aws.amazon.com/redshift/latest/mgmt/db-auditing.html | `string` | `"false"` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | (Optional) If true , the data in the cluster is encrypted at rest. | `bool` | `false` | no |
| <a name="input_enhanced_vpc_routing"></a> [enhanced\_vpc\_routing](#input\_enhanced\_vpc\_routing) | (Optional) If true, enhanced VPC routing is enabled. | `bool` | `false` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | (Optional) The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, 'skip\_final\_snapshot' must be false. | `string` | `""` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) The ARN for the KMS encryption key. When specifying kms\_key\_id, encrypted needs to be set to true. | `string` | `""` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | (Optional, required when enable\_logging is true) The name of an existing S3 bucket where the log files are to be stored. Must be in the same region as the cluster and the cluster must have read bucket and put object permissions. | `string` | `null` | no |
| <a name="input_logging_s3_key_prefix"></a> [logging\_s3\_key\_prefix](#input\_logging\_s3\_key\_prefix) | (Optional) The prefix applied to the log file names. | `string` | `null` | no |
| <a name="input_max_concurrency_scaling_clusters"></a> [max\_concurrency\_scaling\_clusters](#input\_max\_concurrency\_scaling\_clusters) | (Optional) Max concurrency scaling clusters parameter (0 to 10) | `string` | `"1"` | no |
| <a name="input_owner_account"></a> [owner\_account](#input\_owner\_account) | (Optional) The AWS customer account used to create or copy the snapshot. Required if you are restoring a snapshot you do not own, optional if you own the snapshot. | `string` | `null` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the parameter group to be associated with this cluster. If not specified new parameter group will be created. | `string` | `""` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | When AWS can run snapshot, can't overlap with maintenance window | `string` | `"sat:10:00-sat:10:30"` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Determines if Cluster can be publicly available (NOT recommended) | `bool` | `false` | no |
| <a name="input_redshift_subnet_group_name"></a> [redshift\_subnet\_group\_name](#input\_redshift\_subnet\_group\_name) | The name of a cluster subnet group to be associated with this cluster. If not specified, new subnet will be created. | `string` | `""` | no |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Require SSL to connect to this cluster | `string` | `"false"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | If true (default), no snapshot will be made before deleting DB | `bool` | `true` | no |
| <a name="input_snapshot_cluster_identifier"></a> [snapshot\_cluster\_identifier](#input\_snapshot\_cluster\_identifier) | (Optional) The name of the cluster the source snapshot was created from. | `string` | `null` | no |
| <a name="input_snapshot_copy_destination_region"></a> [snapshot\_copy\_destination\_region](#input\_snapshot\_copy\_destination\_region) | (Optional) The name of the region where the snapshot will be copied. | `string` | `null` | no |
| <a name="input_snapshot_copy_grant_name"></a> [snapshot\_copy\_grant\_name](#input\_snapshot\_copy\_grant\_name) | (Optional) The name of the grant in the destination region. Required if you have a KMS encrypted cluster. | `string` | `null` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | (Optional) The name of the snapshot from which to create the new cluster. | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets DB should be available at. It might be one subnet. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_use_fips_ssl"></a> [use\_fips\_ssl](#input\_use\_fips\_ssl) | Enable FIPS-compliant SSL mode only if your system is required to be FIPS compliant. | `string` | `"false"` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster. | `list(string)` | n/a | yes |
| <a name="input_wlm_json_configuration"></a> [wlm\_json\_configuration](#input\_wlm\_json\_configuration) | Configuration bits for WLM json. see https://docs.aws.amazon.com/redshift/latest/mgmt/workload-mgmt-config.html | `string` | `"[{\"query_concurrency\": 5}]"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_redshift_cluster_arn"></a> [redshift\_cluster\_arn](#output\_redshift\_cluster\_arn) | The Redshift cluster ARN |
| <a name="output_redshift_cluster_automated_snapshot_retention_period"></a> [redshift\_cluster\_automated\_snapshot\_retention\_period](#output\_redshift\_cluster\_automated\_snapshot\_retention\_period) | The backup retention period |
| <a name="output_redshift_cluster_availability_zone"></a> [redshift\_cluster\_availability\_zone](#output\_redshift\_cluster\_availability\_zone) | The availability zone of the Cluster |
| <a name="output_redshift_cluster_database_name"></a> [redshift\_cluster\_database\_name](#output\_redshift\_cluster\_database\_name) | The name of the default database in the Cluster |
| <a name="output_redshift_cluster_encrypted"></a> [redshift\_cluster\_encrypted](#output\_redshift\_cluster\_encrypted) | Whether the data in the cluster is encrypted |
| <a name="output_redshift_cluster_endpoint"></a> [redshift\_cluster\_endpoint](#output\_redshift\_cluster\_endpoint) | The connection endpoint |
| <a name="output_redshift_cluster_hostname"></a> [redshift\_cluster\_hostname](#output\_redshift\_cluster\_hostname) | The hostname of the Redshift cluster |
| <a name="output_redshift_cluster_id"></a> [redshift\_cluster\_id](#output\_redshift\_cluster\_id) | The Redshift cluster ID |
| <a name="output_redshift_cluster_identifier"></a> [redshift\_cluster\_identifier](#output\_redshift\_cluster\_identifier) | The Redshift cluster identifier |
| <a name="output_redshift_cluster_node_type"></a> [redshift\_cluster\_node\_type](#output\_redshift\_cluster\_node\_type) | The type of nodes in the cluster |
| <a name="output_redshift_cluster_nodes"></a> [redshift\_cluster\_nodes](#output\_redshift\_cluster\_nodes) | Cluster nodes in the Redshift cluster |
| <a name="output_redshift_cluster_parameter_group_name"></a> [redshift\_cluster\_parameter\_group\_name](#output\_redshift\_cluster\_parameter\_group\_name) | The name of the parameter group to be associated with this cluster |
| <a name="output_redshift_cluster_port"></a> [redshift\_cluster\_port](#output\_redshift\_cluster\_port) | The port the cluster responds on |
| <a name="output_redshift_cluster_preferred_maintenance_window"></a> [redshift\_cluster\_preferred\_maintenance\_window](#output\_redshift\_cluster\_preferred\_maintenance\_window) | The backup window |
| <a name="output_redshift_cluster_public_key"></a> [redshift\_cluster\_public\_key](#output\_redshift\_cluster\_public\_key) | The public key for the cluster |
| <a name="output_redshift_cluster_revision_number"></a> [redshift\_cluster\_revision\_number](#output\_redshift\_cluster\_revision\_number) | The specific revision number of the database in the cluster |
| <a name="output_redshift_cluster_security_groups"></a> [redshift\_cluster\_security\_groups](#output\_redshift\_cluster\_security\_groups) | The security groups associated with the cluster |
| <a name="output_redshift_cluster_subnet_group_name"></a> [redshift\_cluster\_subnet\_group\_name](#output\_redshift\_cluster\_subnet\_group\_name) | The name of a cluster subnet group to be associated with this cluster |
| <a name="output_redshift_cluster_type"></a> [redshift\_cluster\_type](#output\_redshift\_cluster\_type) | The Redshift cluster type |
| <a name="output_redshift_cluster_version"></a> [redshift\_cluster\_version](#output\_redshift\_cluster\_version) | The version of Redshift engine software |
| <a name="output_redshift_cluster_vpc_security_group_ids"></a> [redshift\_cluster\_vpc\_security\_group\_ids](#output\_redshift\_cluster\_vpc\_security\_group\_ids) | The VPC security group ids associated with the cluster |
| <a name="output_redshift_parameter_group_id"></a> [redshift\_parameter\_group\_id](#output\_redshift\_parameter\_group\_id) | The ID of Redshift parameter group created by this module |
| <a name="output_redshift_subnet_group_id"></a> [redshift\_subnet\_group\_id](#output\_redshift\_subnet\_group\_id) | The ID of Redshift subnet group created by this module |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-redshift/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-redshift/tree/master/LICENSE) for full details.
