# Upgrade from v3.x to v4.x

Please consult the `examples` directory for reference example configurations. If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Minimum supported version of Terraform AWS provider updated to v4.16 to support latest resources
- Minimum supported version of Terraform updated to v1.0
- `create` variable added to control whether all resources are created or not. This means that all resources now use the zeroth index `[0]` in the resource name

## Additional changes

### Added

- Support for generating a random password for the `master_password`
- `aws_redshift_snapshot_schedule` resource including the variables and outputs used to support it
- `aws_redshift_snapshot_schedule_association` resource including the variables and outputs used to support it
- `aws_redshift_scheduled_action` resource including support for creating the IAM role and policies plus the associated variables and outputs to support
- `aws_redshift_usage_limit` resource including the variables and outputs used to support it
- `aws_redshift_authentication_profile` resource including the variables and outputs used to support it
- `aws_redshift_hsm_client_certificate` resource including the variables and outputs used to support it

### Modified

- `number_of_nodes` default value of `3` changed to `1`
- `cluster_version` default value of `"1.0"` changed to `null`
- `cluster_node_type` default value of `dc2.large` added
- `master_username` default value of `"awsuser"` added
- `encrypted` default value changed to `true`
- By default, a randomly generated password of length `16` is used for the `master_password`
- `master_password` variable marked as `sensitive`

### Removed

-

### Variable and output changes

1. Removed variables:

  - Parameter Group
    - `wlm_json_configuration`, `require_ssl`, `use_fips_ssl`, `enable_user_activity_logging`, `max_concurrency_scaling_clusters`, `enable_case_sensitive_identifier` have been replaced by the use of `parameter_group_parameters` where any/all of these values can be set as well as others not listed here.

2. Renamed variables:

  - Cluster
    - Cluster variables that per the AWS provider do not start with `cluster_` have been renamed to remove the `cluster_` prefix.
    - `enable_logging`, `logging_bucket_name`, and `logging_s3_key_prefix` have been replaced with the top level variable `logging` where their equivalent parameters `enable`, `bucket_name`, and `s3_key_prefix` are set, and support for new parameters `log_destination_type`, and `log_exports` have been added.
    - `snapshot_copy_destination_region`, `automated_snapshot_retention_period`, `snapshot_copy_grant_name` have been replaced with the top level variable `snapshot_copy` where their equivalent parameters `destination_region`, `retention_period`, and `grant_name` are set.

  - Parameter Group
    - `cluster_parameter_group` ->`parameter_group_family`

  - Subnet Group
    - `redshift_subnet_group_name` -> `subnet_group_name`: Note: this was not previously used in the manner it was intended. The `cluster_identifier` was used as the name of the subnet group. This has now been corrected
    - `subnets` -> `subnet_ids` to match AWS provider

3. Added variables:

  ## Cluster
    - `create` which affects all resources
    - `create_random_password` and `random_password_length` to support generating a random password for the `master_password`
    - `apply_immediately`
    - `aqua_configuration_status`
    - `availability_zone`
    - `availability_zone_relocation_enabled`
    - `default_iam_role_arn`
    - `maintenance_track_name`
    - `manual_snapshot_retention_period`
    - `cluster_timeouts` to support setting `create`, `update`, and `delete` timeout durations

  - Parameter Group
    - `create_parameter_group` was added to replace `length(var.parameter_group_name) > 0` logic
    - `parameter_group_name`
    - `parameter_group_parameters` which allows users to set any number of parameters, replacing the previously hardcoed parameters
    - `parameter_group_tags`

  - Subnet Group
    - `create_subnet_group` was added to replace `var.redshift_subnet_group_name == ""` logic
    - `subnet_group_description` was added to replace the hardcoded description used previously
    - `subnet_group_tags`

4. Removed outputs:

    -

5. Renamed outputs:

    - The preceding `redshift_` prefix has been removed from all outputs

6. Added outputs:

    - `cluster_dns_name`
    - `parameter_group_arn`
    - `subnet_group_arn`

## Upgrade Migrations
