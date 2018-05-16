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
| this_redshift_cluster_endpoint | Redshift endpoint |
| this_redshift_cluster_hostname | Redshift hostname |
| this_redshift_cluster_id | The availability zone of the RDS instance |
| this_redshift_cluster_port | Redshift port |
| this_security_group_id | The ID of the security group |
| vpc_id | The ID of the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
