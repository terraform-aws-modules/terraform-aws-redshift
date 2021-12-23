# Complete Redshift example

Configuration in this directory creates VPC with Redshift subnet, security group and Redshift cluster itself.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.57 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.57 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default"></a> [default](#module\_default) | ../../ | n/a |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../ | n/a |
| <a name="module_redshift"></a> [redshift](#module\_redshift) | ../../ | n/a |
| <a name="module_s3_logs"></a> [s3\_logs](#module\_s3\_logs) | terraform-aws-modules/s3-bucket/aws | ~> 2.0 |
| <a name="module_sg"></a> [sg](#module\_sg) | terraform-aws-modules/security-group/aws//modules/redshift | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [random_pet.s3_bucket](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_iam_policy_document.s3_redshift](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_redshift_service_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/redshift_service_account) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Redshift cluster ARN |
| <a name="output_cluster_automated_snapshot_retention_period"></a> [cluster\_automated\_snapshot\_retention\_period](#output\_cluster\_automated\_snapshot\_retention\_period) | The backup retention period |
| <a name="output_cluster_availability_zone"></a> [cluster\_availability\_zone](#output\_cluster\_availability\_zone) | The availability zone of the Cluster |
| <a name="output_cluster_database_name"></a> [cluster\_database\_name](#output\_cluster\_database\_name) | The name of the default database in the Cluster |
| <a name="output_cluster_encrypted"></a> [cluster\_encrypted](#output\_cluster\_encrypted) | Whether the data in the cluster is encrypted |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The connection endpoint |
| <a name="output_cluster_hostname"></a> [cluster\_hostname](#output\_cluster\_hostname) | The hostname of the Redshift cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The Redshift cluster ID |
| <a name="output_cluster_identifier"></a> [cluster\_identifier](#output\_cluster\_identifier) | The Redshift cluster identifier |
| <a name="output_cluster_node_type"></a> [cluster\_node\_type](#output\_cluster\_node\_type) | The type of nodes in the cluster |
| <a name="output_cluster_nodes"></a> [cluster\_nodes](#output\_cluster\_nodes) | The nodes in the cluster. Each node is a map of the following attributes: `node_role`, `private_ip_address`, and `public_ip_address` |
| <a name="output_cluster_parameter_group_name"></a> [cluster\_parameter\_group\_name](#output\_cluster\_parameter\_group\_name) | The name of the parameter group to be associated with this cluster |
| <a name="output_cluster_port"></a> [cluster\_port](#output\_cluster\_port) | The port the cluster responds on |
| <a name="output_cluster_preferred_maintenance_window"></a> [cluster\_preferred\_maintenance\_window](#output\_cluster\_preferred\_maintenance\_window) | The backup window |
| <a name="output_cluster_public_key"></a> [cluster\_public\_key](#output\_cluster\_public\_key) | The public key for the cluster |
| <a name="output_cluster_revision_number"></a> [cluster\_revision\_number](#output\_cluster\_revision\_number) | The specific revision number of the database in the cluster |
| <a name="output_cluster_security_groups"></a> [cluster\_security\_groups](#output\_cluster\_security\_groups) | The security groups associated with the cluster |
| <a name="output_cluster_subnet_group_name"></a> [cluster\_subnet\_group\_name](#output\_cluster\_subnet\_group\_name) | The name of a cluster subnet group to be associated with this cluster |
| <a name="output_cluster_type"></a> [cluster\_type](#output\_cluster\_type) | The Redshift cluster type |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The version of Redshift engine software |
| <a name="output_cluster_vpc_security_group_ids"></a> [cluster\_vpc\_security\_group\_ids](#output\_cluster\_vpc\_security\_group\_ids) | The VPC security group ids associated with the cluster |
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | Amazon Resource Name (ARN) of the parameter group created |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The name of the Redshift parameter group created |
| <a name="output_subnet_group_arn"></a> [subnet\_group\_arn](#output\_subnet\_group\_arn) | Amazon Resource Name (ARN) of the Redshift subnet group created |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | The ID of Redshift Subnet group created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
