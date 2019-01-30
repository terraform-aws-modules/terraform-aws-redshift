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
## Outputs

| Name | Description |
|------|-------------|
| this\_redshift\_cluster\_endpoint | Redshift endpoint |
| this\_redshift\_cluster\_hostname | Redshift hostname |
| this\_redshift\_cluster\_id | The availability zone of the RDS instance |
| this\_redshift\_cluster\_port | Redshift port |
| this\_security\_group\_id | The ID of the security group |
| vpc\_id | The ID of the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
