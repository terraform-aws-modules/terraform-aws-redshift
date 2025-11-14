# Upgrade from v6.x to v7.x

Please consult the `examples` directory for reference example configurations. If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Terraform `v1.11` is now minimum supported version to support write-only (`wo_*`) attributes.
- AWS provider `v6.18` is now minimum supported version
- The ability for the module to create a random password has been removed in order to ensure passwords are not stored in plain text within the state file. Users must now provide their own password via the `master_password_wo` variable.

## Additional changes

### Added

- Support for `region` argument to specify the AWS region for the resources created if different from the provider region.
- Support for creating security group

### Modified

- Variable definitions now contain detailed `object` types in place of the previously used any type.
- Default value for `parameter_group_family` changed from `redshift-1.0` to `redshift-2.0`

### Removed

-

### Variable and output changes

1. Removed variables:

    - `create_random_password` removed along with support for generating a random password
    - `random_password_length` removed along with support for generating a random password
    - `aqua_configuration_status` argument was deprecated
    - The variables for endpoint access have been nested under a single, top-level `endpoint_access` variable:
        - `create_endpoint_access` removed - set `endpoint_access` to `null` or omit to disable
        - `endpoint_name`
        - `endpoint_resource_owner`
        - `endpoint_subnet_group_name`
        - `endpoint_vpc_security_group_ids`

2. Renamed variables:

    -

3. Added variables:

    - `region`
    - `create_security_group`
    - `security_group_name`
    - `security_group_use_name_prefix`
    - `security_group_description`
    - `vpc_id`
    - `security_group_ingress_rules`
    - `security_group_egress_rules`

4. Removed outputs:

    -

5. Renamed outputs:

    -

6. Added outputs:

    -

## Upgrade Migration

### Before v6.x Example

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 6.0"

  # Only the affected attributes are shown
}
```

### After v7.x Example

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 7.0"

  # Only the affected attributes are shown
}
```

### State Move Commands

TBD
