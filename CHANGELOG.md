<a name="unreleased"></a>
## [Unreleased]



<a name="v2.2.0"></a>
## [v2.2.0] - 2019-11-02

- Added missing descriptions to vars


<a name="v2.1.0"></a>
## [v2.1.0] - 2019-07-08

- Updated CHANGELOG
- Add Redshift cluster ARN to output ([#18](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/18))


<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-12

- Updated CHANGELOG
- Upgraded module to support Terraform 0.12 ([#16](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/16))


<a name="v1.7.0"></a>
## [v1.7.0] - 2019-06-12

- Updated CHANGELOG
- Added CHANGELOG
- Allow restore Redshift from snapshot ([#14](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/14))


<a name="v1.6.0"></a>
## [v1.6.0] - 2019-01-30

- Run pre-commit hook
- Merge pull request [#9](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/9) from gpanula/expanded_parameters
- add some useful descriptions to the variables
- add bits back in to allow for providing existing subnet and/or parameter groups
- only lowercase alphanumeric characters and hyphens allowed in parameter group name
- always create a custom parameter group
- add a few more parameter group knobs


<a name="v1.5.0"></a>
## [v1.5.0] - 2019-01-30

- Merge pull request [#13](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/13) from firstlookmedia/master
- ignore git master_password changes
- add support for passing ignored_changes


<a name="v1.4.0"></a>
## [v1.4.0] - 2018-09-04

- Fixed example: subnets and vpc_security_group_ids (required). Resolves [#6](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/6)


<a name="v1.3.0"></a>
## [v1.3.0] - 2018-08-18

- Merge pull request [#8](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/8) from terraform-aws-modules/remove_lifecycle_to_destroy
- Removed lifecycle to allow to destroy the cluster


<a name="v1.2.0"></a>
## [v1.2.0] - 2018-05-16

- Added pre-commit hook to autogenerate terraform-docs


<a name="v1.1.0"></a>
## [v1.1.0] - 2018-04-27

- Merge pull request [#5](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/5) from sc250024/enhanced-redshift-functionality
- Restored some of the logic of `enable_create_redshift_*` locals
- Moving tags and lifecycle to the end
- Removing duplicate types
- Switching order; got it wrong initially
- I guess you can’t do that :( [hashicorp/terraform/issues/3640]
- Prevent destroy and spaces
- Final snapshot, logging, and instance types
- Adding `allow_version_upgrade` functionality
- Adding `cluster_type` functionality
- Adding `enhanced_vpc_routing` as an option
- Fixing issue [#4](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/4)


<a name="v1.0.0"></a>
## [v1.0.0] - 2018-03-14

- Added examples, updated code, etc


<a name="v0.0.3"></a>
## [v0.0.3] - 2018-03-14

- Initial migration


<a name="v0.0.1"></a>
## [v0.0.1] - 2017-09-26



<a name="v0.0.2"></a>
## v0.0.2 - 2017-09-26

- Initial commit
- Initial commit


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.2.0...HEAD
[v2.2.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.1.0...v2.2.0
[v2.1.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.0.0...v2.1.0
[v2.0.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.7.0...v2.0.0
[v1.7.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.6.0...v1.7.0
[v1.6.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.5.0...v1.6.0
[v1.5.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.4.0...v1.5.0
[v1.4.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.3.0...v1.4.0
[v1.3.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.2.0...v1.3.0
[v1.2.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v1.0.0...v1.1.0
[v1.0.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v0.0.3...v1.0.0
[v0.0.3]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v0.0.1...v0.0.3
[v0.0.1]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v0.0.2...v0.0.1
