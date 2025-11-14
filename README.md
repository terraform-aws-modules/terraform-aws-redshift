# AWS Redshift Terraform module

Terraform module which creates Redshift resources on AWS.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"

  cluster_identifier    = "example"
  allow_version_upgrade = true
  node_type             = "ra3.xlplus"
  number_of_nodes       = 3

  database_name   = "mydb"
  master_username = "mydbuser"

  manage_master_password                       = true
  manage_master_password_rotation              = true
  master_password_rotation_schedule_expression = "rate(90 days)"

  encrypted   = true
  kms_key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"

  enhanced_vpc_routing                 = true
  availability_zone_relocation_enabled = true

  snapshot_copy = {
    destination_region = "us-east-1"
    grant_name         = "example-grant"
  }

  logging = {
    bucket_name   = "my-s3-log-bucket"
    s3_key_prefix = "example/"
  }

  # Parameter group
  parameter_group_name        = "example-custom"
  parameter_group_description = "Custom parameter group for example cluster"
  parameter_group_parameters = {
    wlm_json_configuration = {
      name = "wlm_json_configuration"
      value = jsonencode([
        {
          query_concurrency = 15
        }
      ])
    }
    require_ssl = {
      name  = "require_ssl"
      value = true
    }
    use_fips_ssl = {
      name  = "use_fips_ssl"
      value = false
    }
    enable_user_activity_logging = {
      name  = "enable_user_activity_logging"
      value = true
    }
    max_concurrency_scaling_clusters = {
      name  = "max_concurrency_scaling_clusters"
      value = 3
    }
    enable_case_sensitive_identifier = {
      name  = "enable_case_sensitive_identifier"
      value = true
    }
  }
  parameter_group_tags = {
    Additional = "CustomParameterGroup"
  }

  # Subnet group
  subnet_group_name        = "example-custom"
  subnet_group_description = "Custom subnet group for example cluster"
  subnet_ids               = ["subnet-123456", "subnet-654321"]
  subnet_group_tags = {
    Additional = "CustomSubnetGroup"
  }

  # Snapshot schedule
  snapshot_schedule = {
    identifier    = "example"
    use_prefix    = true
    description   = "Example snapshot schedule"
    definitions   = ["rate(12 hours)"]
    force_destroy = true
  }

  # Scheduled actions
  create_scheduled_action_iam_role = true
  scheduled_actions = {
    pause = {
      name          = "example-pause"
      description   = "Pause cluster every night"
      schedule      = "cron(0 22 * * ? *)"
      target_action = {
        pause_cluster = true
      }
    }
    resize = {
      name        = "example-resize"
      description = "Resize cluster (demo only)"
      schedule    = "cron(00 13 * * ? *)"
      target_action = {
        resize_cluster = {
          node_type       = "ds2.xlarge"
          number_of_nodes = 5
        }
      }
    }
    resume = {
      name           = "example-resume"
      description    = "Resume cluster every morning"
      schedule       = "cron(0 12 * * ? *)"
      target_action = {
        resume_cluster = true
      }
    }
  }

  # Endpoint access
  endpoint_access = {
    example = {
      name                   = "example-example"
      subnet_group_name      = "example-subnet-group"
      vpc_security_group_ids = ["sg-12345678"]
    }
  }

  # Usage limits
  usage_limits = {
    currency_scaling = {
      feature_type  = "concurrency-scaling"
      limit_type    = "time"
      amount        = 60
      breach_action = "emit-metric"
    }
    spectrum = {
      feature_type  = "spectrum"
      limit_type    = "data-scanned"
      amount        = 2
      breach_action = "disable"
      tags = {
        Additional = "CustomUsageLimits"
      }
    }
  }

  # Authentication profile
  authentication_profiles = {
    example = {
      name = "example"
      content = {
        AllowDBUserOverride = "1"
        Client_ID           = "ExampleClientID"
        App_ID              = "example"
      }
    }
    bar = {
      content = {
        AllowDBUserOverride = "1"
        Client_ID           = "ExampleClientID"
        App_ID              = "bar"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

## Examples

- [Complete Redshift example](https://github.com/terraform-aws-modules/terraform-aws-redshift/tree/master/examples/complete) creates VPC with Redshift subnet, VPC security group and Redshift cluster itself.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.21 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.scheduled_action](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.scheduled_action](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_redshift_authentication_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_authentication_profile) | resource |
| [aws_redshift_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster) | resource |
| [aws_redshift_cluster_iam_roles.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster_iam_roles) | resource |
| [aws_redshift_endpoint_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_endpoint_access) | resource |
| [aws_redshift_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_logging) | resource |
| [aws_redshift_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_parameter_group) | resource |
| [aws_redshift_scheduled_action.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_scheduled_action) | resource |
| [aws_redshift_snapshot_copy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_snapshot_copy) | resource |
| [aws_redshift_snapshot_schedule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_snapshot_schedule) | resource |
| [aws_redshift_snapshot_schedule_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_snapshot_schedule_association) | resource |
| [aws_redshift_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |
| [aws_redshift_usage_limit.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_usage_limit) | resource |
| [aws_secretsmanager_secret_rotation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_iam_policy_document.scheduled_action](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.scheduled_action_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_service_principal.scheduler_redshift](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_version_upgrade"></a> [allow\_version\_upgrade](#input\_allow\_version\_upgrade) | If `true`, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default is `true` | `bool` | `null` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false` | `bool` | `null` | no |
| <a name="input_authentication_profiles"></a> [authentication\_profiles](#input\_authentication\_profiles) | Map of authentication profiles to create | <pre>map(object({<br/>    name    = optional(string) # Will fall back to key if not set<br/>    content = any<br/>  }))</pre> | `{}` | no |
| <a name="input_automated_snapshot_retention_period"></a> [automated\_snapshot\_retention\_period](#input\_automated\_snapshot\_retention\_period) | The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Even if automated snapshots are disabled, you can still create manual snapshots when you want with create-cluster-snapshot. Default is 1 | `number` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster. Can only be changed if `availability_zone_relocation_enabled` is `true` | `string` | `null` | no |
| <a name="input_availability_zone_relocation_enabled"></a> [availability\_zone\_relocation\_enabled](#input\_availability\_zone\_relocation\_enabled) | If `true`, the cluster can be relocated to another availability zone, either automatically by AWS or when requested. Default is `false`. Available for use on clusters from the RA3 instance family | `bool` | `null` | no |
| <a name="input_cloudwatch_log_group_kms_key_id"></a> [cloudwatch\_log\_group\_kms\_key\_id](#input\_cloudwatch\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | The number of days to retain CloudWatch logs for the redshift cluster | `number` | `0` | no |
| <a name="input_cloudwatch_log_group_skip_destroy"></a> [cloudwatch\_log\_group\_skip\_destroy](#input\_cloudwatch\_log\_group\_skip\_destroy) | Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state | `bool` | `null` | no |
| <a name="input_cloudwatch_log_group_tags"></a> [cloudwatch\_log\_group\_tags](#input\_cloudwatch\_log\_group\_tags) | Additional tags to add to cloudwatch log groups created | `map(string)` | `{}` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | The Cluster Identifier. Must be a lower case string | `string` | `""` | no |
| <a name="input_cluster_timeouts"></a> [cluster\_timeouts](#input\_cluster\_timeouts) | Create, update, and delete timeout configurations for the cluster | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The version of the Amazon Redshift engine software that you want to deploy on the cluster. The version selected runs on all the nodes in the cluster | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether to create Redshift cluster and resources (affects all resources) | `bool` | `true` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether a CloudWatch log group is created for each `var.logging.log_exports` | `bool` | `false` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | Determines whether to create a parameter group or use existing | `bool` | `true` | no |
| <a name="input_create_scheduled_action_iam_role"></a> [create\_scheduled\_action\_iam\_role](#input\_create\_scheduled\_action\_iam\_role) | Determines whether a scheduled action IAM role is created | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines whether to create security group for Redshift cluster | `bool` | `true` | no |
| <a name="input_create_subnet_group"></a> [create\_subnet\_group](#input\_create\_subnet\_group) | Determines whether to create a subnet group or use existing | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the first database to be created when the cluster is created. If you do not provide a name, Amazon Redshift will create a default database called `dev` | `string` | `null` | no |
| <a name="input_default_iam_role_arn"></a> [default\_iam\_role\_arn](#input\_default\_iam\_role\_arn) | The Amazon Resource Name (ARN) for the IAM role that was set as default for the cluster when the cluster was created | `string` | `null` | no |
| <a name="input_elastic_ip"></a> [elastic\_ip](#input\_elastic\_ip) | The Elastic IP (EIP) address for the cluster | `string` | `null` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | If `true`, the data in the cluster is encrypted at rest | `bool` | `true` | no |
| <a name="input_endpoint_access"></a> [endpoint\_access](#input\_endpoint\_access) | Map of endpoint access (managed VPC endpoint) definitions to create | <pre>map(object({<br/>    name                   = optional(string) # Will fall back to key if not set<br/>    resource_owner         = optional(string)<br/>    subnet_group_name      = string<br/>    vpc_security_group_ids = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_enhanced_vpc_routing"></a> [enhanced\_vpc\_routing](#input\_enhanced\_vpc\_routing) | If `true`, enhanced VPC routing is enabled | `bool` | `null` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, `skip_final_snapshot` must be `false` | `string` | `null` | no |
| <a name="input_iam_role_arns"></a> [iam\_role\_arns](#input\_iam\_role\_arns) | A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time | `list(string)` | `[]` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | Description of the scheduled action IAM role | `string` | `null` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name to use on scheduled action IAM role created | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | Scheduled action IAM role path | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the scheduled action IAM role | `string` | `null` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | A map of additional tags to add to the scheduled action IAM role created | `map(string)` | `{}` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | Determines whether scheduled action the IAM role name (`iam_role_name`) is used as a prefix | `string` | `true` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN for the KMS encryption key. When specifying `kms_key_arn`, `encrypted` needs to be set to `true` | `string` | `null` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Logging configuration for the cluster | <pre>object({<br/>    bucket_name          = optional(string)<br/>    log_destination_type = optional(string)<br/>    log_exports          = optional(list(string))<br/>    s3_key_prefix        = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_maintenance_track_name"></a> [maintenance\_track\_name](#input\_maintenance\_track\_name) | The name of the maintenance track for the restored cluster. When you take a snapshot, the snapshot inherits the MaintenanceTrack value from the cluster. The snapshot might be on a different track than the cluster that was the source for the snapshot. Default value is `current` | `string` | `null` | no |
| <a name="input_manage_master_password"></a> [manage\_master\_password](#input\_manage\_master\_password) | Whether to use AWS SecretsManager to manage the cluster admin credentials. Conflicts with `master_password`. One of `master_password` or `manage_master_password` is required unless `snapshot_identifier` is provided | `bool` | `false` | no |
| <a name="input_manage_master_password_rotation"></a> [manage\_master\_password\_rotation](#input\_manage\_master\_password\_rotation) | Whether to manage the master user password rotation. Setting this value to false after previously having been set to true will disable automatic rotation | `bool` | `false` | no |
| <a name="input_manual_snapshot_retention_period"></a> [manual\_snapshot\_retention\_period](#input\_manual\_snapshot\_retention\_period) | The default number of days to retain a manual snapshot. If the value is -1, the snapshot is retained indefinitely. This setting doesn't change the retention period of existing snapshots. Valid values are between `-1` and `3653`. Default value is `-1` | `number` | `null` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Password for the master DB user. (Required unless a `snapshot_identifier` is provided). Must contain at least 8 chars, one uppercase letter, one lowercase letter, and one number | `string` | `null` | no |
| <a name="input_master_password_rotate_immediately"></a> [master\_password\_rotate\_immediately](#input\_master\_password\_rotate\_immediately) | Specifies whether to rotate the secret immediately or wait until the next scheduled rotation window | `bool` | `null` | no |
| <a name="input_master_password_rotation_automatically_after_days"></a> [master\_password\_rotation\_automatically\_after\_days](#input\_master\_password\_rotation\_automatically\_after\_days) | Specifies the number of days between automatic scheduled rotations of the secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified | `number` | `null` | no |
| <a name="input_master_password_rotation_duration"></a> [master\_password\_rotation\_duration](#input\_master\_password\_rotation\_duration) | The length of the rotation window in hours. For example, 3h for a three hour window | `string` | `null` | no |
| <a name="input_master_password_rotation_schedule_expression"></a> [master\_password\_rotation\_schedule\_expression](#input\_master\_password\_rotation\_schedule\_expression) | A cron() or rate() expression that defines the schedule for rotating your secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified | `string` | `null` | no |
| <a name="input_master_password_secret_kms_key_id"></a> [master\_password\_secret\_kms\_key\_id](#input\_master\_password\_secret\_kms\_key\_id) | ID of the KMS key used to encrypt the cluster admin credentials secret | `string` | `null` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Username for the master DB user (Required unless a `snapshot_identifier` is provided). Defaults to `awsuser` | `string` | `"awsuser"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Specifies if the Redshift cluster is multi-AZ | `bool` | `null` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The node type to be provisioned for the cluster | `string` | `""` | no |
| <a name="input_number_of_nodes"></a> [number\_of\_nodes](#input\_number\_of\_nodes) | Number of nodes in the cluster. Defaults to 1. Note: values greater than 1 will trigger `cluster_type` to switch to `multi-node` | `number` | `1` | no |
| <a name="input_owner_account"></a> [owner\_account](#input\_owner\_account) | The AWS customer account used to create or copy the snapshot. Required if you are restoring a snapshot you do not own, optional if you own the snapshot | `string` | `null` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | The description of the Redshift parameter group. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the Redshift parameter group | `string` | `"redshift-2.0"` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the Redshift parameter group, existing or to be created | `string` | `null` | no |
| <a name="input_parameter_group_parameters"></a> [parameter\_group\_parameters](#input\_parameter\_group\_parameters) | A list of Redshift parameters to apply | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `null` | no |
| <a name="input_parameter_group_tags"></a> [parameter\_group\_tags](#input\_parameter\_group\_tags) | Additional tags to add to the parameter group | `map(string)` | `{}` | no |
| <a name="input_port"></a> [port](#input\_port) | The port number on which the cluster accepts incoming connections. Default port is `5439` | `number` | `5439` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | The weekly time range (in UTC) during which automated cluster maintenance can occur. Format: `ddd:hh24:mi-ddd:hh24:mi` | `string` | `"sat:10:00-sat:10:30"` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | If true, the cluster can be accessed from a public network | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_scheduled_actions"></a> [scheduled\_actions](#input\_scheduled\_actions) | Map of scheduled action definitions to create | <pre>map(object({<br/>    name        = optional(string) # Will fall back to key if not set<br/>    description = optional(string)<br/>    enable      = optional(bool)<br/>    start_time  = optional(string)<br/>    end_time    = optional(string)<br/>    schedule    = string<br/>    iam_role    = optional(string)<br/>    target_action = object({<br/>      pause_cluster = optional(bool, false)<br/>      resize_cluster = optional(object({<br/>        classic         = optional(bool)<br/>        cluster_type    = optional(string)<br/>        node_type       = optional(string)<br/>        number_of_nodes = optional(number)<br/>      }))<br/>      resume_cluster = optional(bool, false)<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description of the security group. If value is set to empty string it will contain cluster name in the description | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Map of security group egress rules to add to the security group created | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    region                       = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Map of security group ingress rules to add to the security group created | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    region                       = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The security group name | `string` | `""` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | Additional tags for the security group | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final snapshot of the cluster is created before Redshift deletes the cluster. If true, a final cluster snapshot is not created. If false , a final cluster snapshot is created before the cluster is deleted | `bool` | `true` | no |
| <a name="input_snapshot_cluster_identifier"></a> [snapshot\_cluster\_identifier](#input\_snapshot\_cluster\_identifier) | The name of the cluster the source snapshot was created from | `string` | `null` | no |
| <a name="input_snapshot_copy"></a> [snapshot\_copy](#input\_snapshot\_copy) | Configuration of automatic copy of snapshots from one region to another | <pre>object({<br/>    destination_region               = string<br/>    manual_snapshot_retention_period = optional(number)<br/>    retention_period                 = optional(number)<br/>    grant_name                       = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | The name of the snapshot from which to create the new cluster | `string` | `null` | no |
| <a name="input_snapshot_schedule"></a> [snapshot\_schedule](#input\_snapshot\_schedule) | Configuration for creating a snapshot schedule and associating it with the cluster | <pre>object({<br/>    definitions   = list(string)<br/>    description   = optional(string)<br/>    force_destroy = optional(bool)<br/>    use_prefix    = optional(bool, false)<br/>    identifier    = optional(string)<br/>    tags          = optional(map(string), {})<br/>  })</pre> | `null` | no |
| <a name="input_subnet_group_description"></a> [subnet\_group\_description](#input\_subnet\_group\_description) | The description of the Redshift Subnet group. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | The name of the Redshift subnet group, existing or to be created | `string` | `null` | no |
| <a name="input_subnet_group_tags"></a> [subnet\_group\_tags](#input\_subnet\_group\_tags) | Additional tags to add to the subnet group | `map(string)` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | An array of VPC subnet IDs to use in the subnet group | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_usage_limits"></a> [usage\_limits](#input\_usage\_limits) | Map of usage limit definitions to create | <pre>map(object({<br/>    amount        = number<br/>    breach_action = optional(string)<br/>    feature_type  = string<br/>    limit_type    = optional(string) # Will fall back to key if not set<br/>    period        = optional(string)<br/>    tags          = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster | `list(string)` | `[]` | no |

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
| <a name="output_cluster_master_password"></a> [cluster\_master\_password](#output\_cluster\_master\_password) | The Redshift cluster master password |
| <a name="output_cluster_master_username"></a> [cluster\_master\_username](#output\_cluster\_master\_username) | The Redshift cluster master username |
| <a name="output_cluster_namespace_arn"></a> [cluster\_namespace\_arn](#output\_cluster\_namespace\_arn) | The namespace Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_node_type"></a> [cluster\_node\_type](#output\_cluster\_node\_type) | The type of nodes in the cluster |
| <a name="output_cluster_nodes"></a> [cluster\_nodes](#output\_cluster\_nodes) | The nodes in the cluster. Each node is a map of the following attributes: `node_role`, `private_ip_address`, and `public_ip_address` |
| <a name="output_cluster_parameter_group_name"></a> [cluster\_parameter\_group\_name](#output\_cluster\_parameter\_group\_name) | The name of the parameter group to be associated with this cluster |
| <a name="output_cluster_port"></a> [cluster\_port](#output\_cluster\_port) | The port the cluster responds on |
| <a name="output_cluster_preferred_maintenance_window"></a> [cluster\_preferred\_maintenance\_window](#output\_cluster\_preferred\_maintenance\_window) | The backup window |
| <a name="output_cluster_public_key"></a> [cluster\_public\_key](#output\_cluster\_public\_key) | The public key for the cluster |
| <a name="output_cluster_revision_number"></a> [cluster\_revision\_number](#output\_cluster\_revision\_number) | The specific revision number of the database in the cluster |
| <a name="output_cluster_secretsmanager_secret_rotation_enabled"></a> [cluster\_secretsmanager\_secret\_rotation\_enabled](#output\_cluster\_secretsmanager\_secret\_rotation\_enabled) | Specifies whether automatic rotation is enabled for the secret |
| <a name="output_cluster_subnet_group_name"></a> [cluster\_subnet\_group\_name](#output\_cluster\_subnet\_group\_name) | The name of a cluster subnet group to be associated with this cluster |
| <a name="output_cluster_type"></a> [cluster\_type](#output\_cluster\_type) | The Redshift cluster type |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The version of Redshift engine software |
| <a name="output_cluster_vpc_security_group_ids"></a> [cluster\_vpc\_security\_group\_ids](#output\_cluster\_vpc\_security\_group\_ids) | The VPC security group ids associated with the cluster |
| <a name="output_endpoint_access_address"></a> [endpoint\_access\_address](#output\_endpoint\_access\_address) | The DNS address of the endpoint |
| <a name="output_endpoint_access_id"></a> [endpoint\_access\_id](#output\_endpoint\_access\_id) | The Redshift-managed VPC endpoint name |
| <a name="output_endpoint_access_port"></a> [endpoint\_access\_port](#output\_endpoint\_access\_port) | The port number on which the cluster accepts incoming connections |
| <a name="output_endpoint_access_vpc_endpoint"></a> [endpoint\_access\_vpc\_endpoint](#output\_endpoint\_access\_vpc\_endpoint) | The connection endpoint for connecting to an Amazon Redshift cluster through the proxy. See details below |
| <a name="output_master_password_secret_arn"></a> [master\_password\_secret\_arn](#output\_master\_password\_secret\_arn) | ARN of managed master password secret |
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

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-redshift/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-redshift/tree/master/LICENSE) for full details.
