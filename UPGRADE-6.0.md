# Upgrade from v5.x to v6.x

Please consult the `examples` directory for reference example configurations. If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Minimum supported version of Terraform AWS provider updated to `v5.45` to support latest resources
- Minimum supported version of Terraform raised to `v1.3`
- logging block within the `aws_redshift_cluster` resource has been replaced with a standalone resource. After upgrade, a new resource for logging will be created.
- snapshot_copy block within the `aws_redshift_cluster` resource has been replaced with a standalone resource. After upgrade, to prevent errors due to already existing `snapshot_copy` configurations, import of the new resource is required.

## Additional changes

### Added

- `aws_redshift_logging` has been added to replace `logging` block in `aws_redshift_cluster`
- `aws_redshift_snapshot_copy` has been added to replace `snapshot_copy` block in `aws_redshift_cluster`

### Modified

- None

### Removed

- `logging` block in `aws_redshift_cluster`
- `snapshot_copy` block in `aws_redshift_cluster`

### Variable and output changes

1. Removed variables:

  - Cluster
    - `var.logging.enable` has been removed

2. Renamed variables:

  - None

3. Added variables:

  - Snapshot Copy
    - `var.snapshot_copy.manual_snapshot_retention_period`

4. Removed outputs:

  - None

5. Renamed outputs:

  - None

6. Added outputs:

  - None

## Upgrade Migration

### Before v5.x Example

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 5.0"

  snapshot_copy = {
    destination_region = "us-east-1"
    grant_name         = aws_redshift_snapshot_copy_grant.useast1.snapshot_copy_grant_name
  }

  logging = {
    enable        = true
    bucket_name   = module.s3_logs.s3_bucket_id
    s3_key_prefix = local.s3_prefix
  }
}
```

### After v6.x Example

```hcl
module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 6.0"

  snapshot_copy = {
    destination_region = "us-east-1"
    grant_name         = aws_redshift_snapshot_copy_grant.useast1.snapshot_copy_grant_name
  }

  logging = {
    bucket_name   = module.s3_logs.s3_bucket_id
    s3_key_prefix = local.s3_prefix
  }
}
```

### Diff of Before vs After

```diff
  # module.redshift.aws_redshift_logging.this[0] will be created
  + resource "aws_redshift_logging" "this" {
      + bucket_name        = "ex-complete20240414012816938100000003"
      + cluster_identifier = "ex-complete"
      + id                 = (known after apply)
      + s3_key_prefix      = "redshift/ex-complete/"
    }

  # module.redshift.aws_redshift_snapshot_copy.this[0] will be created
  + resource "aws_redshift_snapshot_copy" "this" {
      + cluster_identifier               = "ex-complete"
      + destination_region               = "us-east-1"
      + id                               = (known after apply)
      + manual_snapshot_retention_period = (known after apply)
      + retention_period                 = (known after apply)
      + snapshot_copy_grant_name         = "ex-complete-us-east-1"
    }
```
The `aws_redshift_logging` can be applied or imported. If setting the `log_destination_type`, an apply following an import will be required to clear the remaining diff.
The `aws_redshift_snapshot_copy` resource requires importing if an existing snapshot_copy configuration exists.

### State Move Commands

None required

### State Import Commands

During the migration to v6.x of this module, logging and snapshot_copy resources will be created by this module if those settings are configured. In order to guarantee the best experience and prevent data loss, you will need to import them into terraform state using commands like these:

```bash
terraform import 'module.redshift.aws_redshift_logging.this[0]' <cluster-id>
terraform import 'module.redshift.aws_redshift_snapshot_copy.this[0]' <cluster-id>
```
