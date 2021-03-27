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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.25 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redshift"></a> [redshift](#module\_redshift) | ../../ |  |
| <a name="module_sg"></a> [sg](#module\_sg) | terraform-aws-modules/security-group/aws//modules/redshift | ~> 3.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 2.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_redshift_cluster_endpoint"></a> [this\_redshift\_cluster\_endpoint](#output\_this\_redshift\_cluster\_endpoint) | Redshift endpoint |
| <a name="output_this_redshift_cluster_hostname"></a> [this\_redshift\_cluster\_hostname](#output\_this\_redshift\_cluster\_hostname) | Redshift hostname |
| <a name="output_this_redshift_cluster_id"></a> [this\_redshift\_cluster\_id](#output\_this\_redshift\_cluster\_id) | The availability zone of the RDS instance |
| <a name="output_this_redshift_cluster_port"></a> [this\_redshift\_cluster\_port](#output\_this\_redshift\_cluster\_port) | Redshift port |
| <a name="output_this_security_group_id"></a> [this\_security\_group\_id](#output\_this\_security\_group\_id) | The ID of the security group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
