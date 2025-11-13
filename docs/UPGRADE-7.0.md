# Upgrade from v6.x to v7.x

Please consult the `examples` directory for reference example configurations. If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Terraform `v1.11` is now minimum supported version to support write-only (`wo_*`) attributes.
- AWS provider `v6.18` is now minimum supported version
- The ability for the module to create a random password has been removed in order to ensure passwords are not stored in plain text within the state file. Users must now provide their own password via the `master_password_wo` variable.

## Additional changes

### Added

-

### Modified

-

### Removed

-

### Variable and output changes

1. Removed variables:

    - `create_random_password`
    - `random_password_length`

2. Renamed variables:

    -

3. Added variables:

    -

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
