# Changelog

All notable changes to this project will be documented in this file.

## [5.5.0](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v5.4.0...v5.5.0) (2024-05-08)


### Features

* Logging and Snapshot copy resources converted to standalone resource equivalents, MSV of Terraform raised to `v1.3` ([#99](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/99)) ([2a2fbdc](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/2a2fbdcbd25d5b3f11e7b520309165a03aadf3a0))

## [5.4.0](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v5.3.1...v5.4.0) (2024-03-26)


### Features

* Secretsmanager secret rotation for master user password ([#97](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/97)) ([e542e41](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/e542e41b233742bb8789c2a391c2ca89775f7ec3))

## [5.3.1](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v5.3.0...v5.3.1) (2024-03-06)


### Bug Fixes

* Update CI workflow versions to remove deprecated runtime warnings ([#96](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/96)) ([bd1679d](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/bd1679dfb4ea1770598ba72a03558581a9573b40))

## [5.3.0](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v5.2.0...v5.3.0) (2024-02-17)


### Features

* Add support for creating cloudwatch log groups ([#94](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/94)) ([d8e144c](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/d8e144ce91803360c03b1985bdf860966a96dc48))

## [5.2.0](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v5.1.1...v5.2.0) (2024-02-10)


### Features

* Add `multi_az` support and add `cluster_namespace_arn` ([#93](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/93)) ([b4c2141](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/b4c2141e2f62a9507aafa43358e88541ca9993b8))

### [5.1.1](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v5.1.0...v5.1.1) (2024-01-18)


### Bug Fixes

* Correct `try()` lookup on `manage_master_password` variables ([#90](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/90)) ([b1090c4](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/b1090c4a8b95eb0886b6b06343985be1b6f8f8ca))

## [5.1.0](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v5.0.0...v5.1.0) (2024-01-13)


### Features

* Add managed secrets option (release for PR 87) ([51b112f](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/51b112f51f16476ff81ab6157020875e47b8f9fd))

## [5.0.0](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v4.0.3...v5.0.0) (2023-06-06)


### ⚠ BREAKING CHANGES

* Remove deprecated EC2 classic fields removed in AWS provider v5.0 (#86)

### Features

* Remove deprecated EC2 classic fields removed in AWS provider v5.0 ([#86](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/86)) ([41fc56a](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/41fc56a7294ffdde4205c95445f0d8a603ff9711))

### [4.0.3](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v4.0.2...v4.0.3) (2022-10-27)


### Bug Fixes

* Update CI configuration files to use latest version ([#74](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/74)) ([c6f65aa](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/c6f65aa12b6aec53bbcc00357bd4edfe243d4f56))

### [4.0.2](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v4.0.1...v4.0.2) (2022-09-26)


### Bug Fixes

* Master username when specifying snapshot identifier ([#70](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/70)) ([d34e832](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/d34e832246822698b3d12fe1b6bd58f8c79613b1))

### [4.0.1](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v4.0.0...v4.0.1) (2022-07-07)


### Bug Fixes

* Allow usage of log_exports key ([#68](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/68)) ([91264f1](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/91264f100fb21bd7fb3e23a37d3e6238d0fccc3d))

## [4.0.0](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v3.4.1...v4.0.0) (2022-06-14)


### ⚠ BREAKING CHANGES

* Refactor module to align with current standards, add missing addtional Redshift resources to module (#61)

### Features

* Refactor module to align with current standards, add missing addtional Redshift resources to module ([#61](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/61)) ([c8a4c97](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/c8a4c97aa881e4e0d0c24489618704888554f901))

### [3.4.1](https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v3.4.0...v3.4.1) (2022-01-10)


### Bug Fixes

* update CI/CD process to enable auto-release workflow ([#60](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/60)) ([1bc386f](https://github.com/terraform-aws-modules/terraform-aws-redshift/commit/1bc386f275c83d35359a41e9e25644d02920c857))

<a name="v3.4.0"></a>
## [v3.4.0] - 2021-09-03

- feat: Add redshift_cluster_nodes to the outputs ([#58](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/58))


<a name="v3.3.0"></a>
## [v3.3.0] - 2021-08-20

- fix: Add required argument to enable cross-region snapshot copy of KMS encrypted clusters ([#37](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/37))
- docs: Add ra3 node options to cluster_node_type valid values ([#56](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/56))


<a name="v3.2.0"></a>
## [v3.2.0] - 2021-07-07

- docs: Fixed docs
- feat: add elastic_ip parameter ([#55](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/55))


<a name="v3.1.0"></a>
## [v3.1.0] - 2021-06-29

- fix: Allow final_snapshot_identifier to be omitted ([#44](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/44))
- chore: update CI/CD to use stable `terraform-docs` release artifact and discoverable Apache2.0 license ([#54](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/54))


<a name="v3.0.0"></a>
## [v3.0.0] - 2021-04-27

- feat: Shorten outputs (removing this_) ([#53](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/53))


<a name="v2.8.0"></a>
## [v2.8.0] - 2021-04-23

- feat: Add enable_case_sensitive_identifier parameter ([#52](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/52))
- chore: update documentation and pin `terraform_docs` version to avoid future changes ([#50](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/50))
- chore: align ci-cd static checks to use individual minimum Terraform versions ([#49](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/49))
- chore: Fixed module source in example
- chore: add ci-cd workflow for pre-commit checks ([#48](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/48))


<a name="v2.7.0"></a>
## [v2.7.0] - 2020-11-09

- Updated README
- chore: Updated pre-commit
- feat: make max concurrency scaling configurable ([#46](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/46))


<a name="v2.6.0"></a>
## [v2.6.0] - 2020-08-13

- feat: allow AWS provider 3.0 and Terraform 0.13 ([#43](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/43))


<a name="v2.5.0"></a>
## [v2.5.0] - 2020-04-27

- fix: final_snapshot_identifier should be string, not bool ([#35](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/35))


<a name="v2.4.0"></a>
## [v2.4.0] - 2020-02-21

- Add the option to copy snapshots to a different region ([#24](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/24))
- [ADD] missing owner_account var for restoring from cross-account shared shapshot ([#23](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/23))


<a name="v2.3.0"></a>
## [v2.3.0] - 2020-02-18

- Updated pre-commit-terraform
- Add tags to aws_redshift_parameter_group ([#20](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/20))


<a name="v2.2.0"></a>
## [v2.2.0] - 2019-11-02

- Added missing descriptions to vars


<a name="v2.1.0"></a>
## [v2.1.0] - 2019-07-08

- Add Redshift cluster ARN to output ([#18](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/18))


<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-12

- Upgraded module to support Terraform 0.12 ([#16](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/16))


<a name="v1.7.0"></a>
## [v1.7.0] - 2019-06-12

- Allow restore Redshift from snapshot ([#14](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/14))


<a name="v1.6.0"></a>
## [v1.6.0] - 2019-01-30

- Run pre-commit hook
- add some useful descriptions to the variables
- add bits back in to allow for providing existing subnet and/or parameter groups
- only lowercase alphanumeric characters and hyphens allowed in parameter group name
- always create a custom parameter group
- add a few more parameter group knobs


<a name="v1.5.0"></a>
## [v1.5.0] - 2019-01-30

- ignore git master_password changes
- add support for passing ignored_changes


<a name="v1.4.0"></a>
## [v1.4.0] - 2018-09-04

- Fixed example: subnets and vpc_security_group_ids (required). Resolves [#6](https://github.com/terraform-aws-modules/terraform-aws-redshift/issues/6)


<a name="v1.3.0"></a>
## [v1.3.0] - 2018-08-18

- Removed lifecycle to allow to destroy the cluster


<a name="v1.2.0"></a>
## [v1.2.0] - 2018-05-16

- Added pre-commit hook to autogenerate terraform-docs


<a name="v1.1.0"></a>
## [v1.1.0] - 2018-04-27

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


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v3.4.0...HEAD
[v3.4.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v3.3.0...v3.4.0
[v3.3.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v3.2.0...v3.3.0
[v3.2.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v3.1.0...v3.2.0
[v3.1.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v3.0.0...v3.1.0
[v3.0.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.8.0...v3.0.0
[v2.8.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.7.0...v2.8.0
[v2.7.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.6.0...v2.7.0
[v2.6.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.5.0...v2.6.0
[v2.5.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.4.0...v2.5.0
[v2.4.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.3.0...v2.4.0
[v2.3.0]: https://github.com/terraform-aws-modules/terraform-aws-redshift/compare/v2.2.0...v2.3.0
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
