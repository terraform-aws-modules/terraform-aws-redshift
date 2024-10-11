# Complete Redshift example

Configuration in this directory creates AWS Redshift clusters with demonstrating the various methods of configuring/customizing:

- A disabled cluster
- A default, "out of the box" Redshift cluster
- A "complete" cluster demonstrating the broad array of configurations including the use of snapshot copy grants. NOTE: the term "complete" here is used to denote the "compete array of configurations offered" and is not representative of recommended/best practices for provisioning a Redshift cluster. Users should refer to the AWS documenation for recommended practices for provisioning a Redshift cluster.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.45 |
| <a name="provider_aws.us_east_1"></a> [aws.us\_east\_1](#provider\_aws.us\_east\_1) | >= 5.45 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default"></a> [default](#module\_default) | ../../ | n/a |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../ | n/a |
| <a name="module_redshift"></a> [redshift](#module\_redshift) | ../../ | n/a |
| <a name="module_s3_logs"></a> [s3\_logs](#module\_s3\_logs) | terraform-aws-modules/s3-bucket/aws | ~> 3.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws//modules/redshift | ~> 5.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |
| <a name="module_with_cloudwatch_logging"></a> [with\_cloudwatch\_logging](#module\_with\_cloudwatch\_logging) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.redshift](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.redshift_us_east_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_redshift_snapshot_copy_grant.useast1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_snapshot_copy_grant) | resource |
| [aws_redshift_subnet_group.endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.s3_redshift](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_authentication_profiles"></a> [authentication\_profiles](#output\_authentication\_profiles) | Map of authentication profiles created and their associated attributes |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Redshift cluster ARN |
| <a name="output_cluster_automated_snapshot_retention_period"></a> [cluster\_automated\_snapshot\_retention\_period](#output\_cluster\_automated\_snapshot\_retention\_period) | The backup retention period |
| <a name="output_cluster_availability_zone"></a> [cluster\_availability\_zone](#output\_cluster\_availability\_zone) | The availability zone of the Cluster |
| <a name="output_cluster_database_name"></a> [cluster\_database\_name](#output\_cluster\_database\_name) | The name of the default database in the Cluster |
| <a name="output_cluster_dns_name"></a> [cluster\_dns\_name](#output\_cluster\_dns\_name) | The DNS name of the cluster |
| <a name="output_cluster_encrypted"></a> [cluster\_encrypted](#output\_cluster\_encrypted) | Whether the data in the cluster is encrypted |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The connection endpoint |
| <a name="output_cluster_hostname"></a> [cluster\_hostname](#output\_cluster\_hostname) | The hostname of the Redshift cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The Redshift cluster ID |
| <a name="output_cluster_identifier"></a> [cluster\_identifier](#output\_cluster\_identifier) | The Redshift cluster identifier |
| <a name="output_cluster_namespace_arn"></a> [cluster\_namespace\_arn](#output\_cluster\_namespace\_arn) | The namespace Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_node_type"></a> [cluster\_node\_type](#output\_cluster\_node\_type) | The type of nodes in the cluster |
| <a name="output_cluster_nodes"></a> [cluster\_nodes](#output\_cluster\_nodes) | The nodes in the cluster. Each node is a map of the following attributes: `node_role`, `private_ip_address`, and `public_ip_address` |
| <a name="output_cluster_parameter_group_name"></a> [cluster\_parameter\_group\_name](#output\_cluster\_parameter\_group\_name) | The name of the parameter group to be associated with this cluster |
| <a name="output_cluster_port"></a> [cluster\_port](#output\_cluster\_port) | The port the cluster responds on |
| <a name="output_cluster_preferred_maintenance_window"></a> [cluster\_preferred\_maintenance\_window](#output\_cluster\_preferred\_maintenance\_window) | The backup window |
| <a name="output_cluster_public_key"></a> [cluster\_public\_key](#output\_cluster\_public\_key) | The public key for the cluster |
| <a name="output_cluster_revision_number"></a> [cluster\_revision\_number](#output\_cluster\_revision\_number) | The specific revision number of the database in the cluster |
| <a name="output_cluster_subnet_group_name"></a> [cluster\_subnet\_group\_name](#output\_cluster\_subnet\_group\_name) | The name of a cluster subnet group to be associated with this cluster |
| <a name="output_cluster_type"></a> [cluster\_type](#output\_cluster\_type) | The Redshift cluster type |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The version of Redshift engine software |
| <a name="output_cluster_vpc_security_group_ids"></a> [cluster\_vpc\_security\_group\_ids](#output\_cluster\_vpc\_security\_group\_ids) | The VPC security group ids associated with the cluster |
| <a name="output_endpoint_access_address"></a> [endpoint\_access\_address](#output\_endpoint\_access\_address) | The DNS address of the endpoint |
| <a name="output_endpoint_access_id"></a> [endpoint\_access\_id](#output\_endpoint\_access\_id) | The Redshift-managed VPC endpoint name |
| <a name="output_endpoint_access_port"></a> [endpoint\_access\_port](#output\_endpoint\_access\_port) | The port number on which the cluster accepts incoming connections |
| <a name="output_endpoint_access_vpc_endpoint"></a> [endpoint\_access\_vpc\_endpoint](#output\_endpoint\_access\_vpc\_endpoint) | The connection endpoint for connecting to an Amazon Redshift cluster through the proxy. See details below |
| <a name="output_master_password_secret_arn"></a> [master\_password\_secret\_arn](#output\_master\_password\_secret\_arn) | ARN of managed master password secret |
| <a name="output_master_password_secretsmanager_secret_rotation_enabled"></a> [master\_password\_secretsmanager\_secret\_rotation\_enabled](#output\_master\_password\_secretsmanager\_secret\_rotation\_enabled) | Specifies whether automatic rotation is enabled for the secret |
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | Amazon Resource Name (ARN) of the parameter group created |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The name of the Redshift parameter group created |
| <a name="output_scheduled_action_iam_role_arn"></a> [scheduled\_action\_iam\_role\_arn](#output\_scheduled\_action\_iam\_role\_arn) | Scheduled actions IAM role ARN |
| <a name="output_scheduled_action_iam_role_name"></a> [scheduled\_action\_iam\_role\_name](#output\_scheduled\_action\_iam\_role\_name) | Scheduled actions IAM role name |
| <a name="output_scheduled_action_iam_role_unique_id"></a> [scheduled\_action\_iam\_role\_unique\_id](#output\_scheduled\_action\_iam\_role\_unique\_id) | Stable and unique string identifying the scheduled action IAM role |
| <a name="output_scheduled_actions"></a> [scheduled\_actions](#output\_scheduled\_actions) | A map of maps containing scheduled action details |
| <a name="output_snapshot_schedule_arn"></a> [snapshot\_schedule\_arn](#output\_snapshot\_schedule\_arn) | Amazon Resource Name (ARN) of the Redshift Snapshot Schedule |
| <a name="output_subnet_group_arn"></a> [subnet\_group\_arn](#output\_subnet\_group\_arn) | Amazon Resource Name (ARN) of the Redshift subnet group created |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | The ID of Redshift Subnet group created |
| <a name="output_usage_limits"></a> [usage\_limits](#output\_usage\_limits) | Map of usage limits created and their associated attributes |
<!-- END_TF_DOCS -->
