variable "create" {
  description = "Determines whether to create Redshift cluster and resources (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster
################################################################################

variable "cluster_identifier" {
  description = "The Cluster Identifier. Must be a lower case string"
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "The version of the Amazon Redshift engine software that you want to deploy on the cluster. The version selected runs on all the nodes in the cluster"
  type        = string
  default     = null
}

variable "allow_version_upgrade" {
  description = "If true , major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default is `true`"
  type        = bool
  default     = null
}

variable "node_type" {
  description = "The node type to be provisioned for the cluster"
  type        = string
  default     = "dc2.large"
  # Valid Values: ds2.xlarge | ds2.8xlarge | dc1.large | dc1.8xlarge | dc2.large | dc2.8xlarge | ra3.xlplus | ra3.4xlarge | ra3.16xlarge
  # https://awscli.amazonaws.com/v2/documentation/api/latest/reference/redshift/create-cluster.html
}

variable "number_of_nodes" {
  description = "Number of nodes in the cluster. Defaults to 1. Note: values greater than 1 will trigger `cluster_type` to switch to `multi-node`"
  type        = number
  default     = 1
}

variable "port" {
  description = "The port number on which the cluster accepts incoming connections. Default port is 5439"
  type        = number
  default     = null
}

variable "database_name" {
  description = "The name of the first database to be created when the cluster is created. If you do not provide a name, Amazon Redshift will create a default database called `dev`"
  type        = string
  default     = null
}

variable "master_username" {
  description = "Username for the master DB user (Required unless a `snapshot_identifier` is provided). Defaults to `awsuser`"
  type        = string
  default     = "awsuser"
}

variable "create_random_password" {
  description = "Determines whether to create random password for RDS primary cluster"
  type        = bool
  default     = true
}

variable "random_password_length" {
  description = "Length of random password to create. Defaults to `16`"
  type        = number
  default     = 16
}

variable "master_password" {
  description = "Password for the master DB user. (Required unless a `snapshot_identifier` is provided). Must contain at least 8 chars, one uppercase letter, one lowercase letter, and one number"
  type        = string
  default     = null
  sensitive   = true
}

variable "iam_roles" {
  description = "A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time"
  type        = list(string)
  default     = []
}

variable "encrypted" {
  description = "If true, the data in the cluster is encrypted at rest"
  type        = bool
  default     = null
}

variable "kms_key_arn" {
  description = "The ARN for the KMS encryption key. When specifying `kms_key_id`, `encrypted` needs to be set to `true`"
  type        = string
  default     = null
}

variable "enhanced_vpc_routing" {
  description = "If `true`, enhanced VPC routing is enabled"
  type        = bool
  default     = null
}

variable "cluster_security_groups" {
  description = "A list of security groups to be associated with this cluster"
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster"
  type        = list(string)
  default     = null
}

variable "publicly_accessible" {
  description = "If true, the cluster can be accessed from a public network"
  type        = bool
  default     = false
}

variable "elastic_ip" {
  description = "The Elastic IP (EIP) address for the cluster"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster"
  type        = string
  default     = null
}

variable "owner_account" {
  description = "The AWS customer account used to create or copy the snapshot. Required if you are restoring a snapshot you do not own, optional if you own the snapshot"
  type        = string
  default     = null
}

variable "snapshot_identifier" {
  description = "The name of the snapshot from which to create the new cluster"
  type        = string
  default     = null
}

variable "snapshot_cluster_identifier" {
  description = "The name of the cluster the source snapshot was created from"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, `skip_final_snapshot` must be `false`"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot of the cluster is created before Redshift deletes the cluster. If true, a final cluster snapshot is not created. If false , a final cluster snapshot is created before the cluster is deleted"
  type        = bool
  default     = true
}

variable "automated_snapshot_retention_period" {
  description = "The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Even if automated snapshots are disabled, you can still create manual snapshots when you want with create-cluster-snapshot. Default is 1"
  type        = number
  default     = null
}

variable "preferred_maintenance_window" {
  description = "The weekly time range (in UTC) during which automated cluster maintenance can occur. Format: `ddd:hh24:mi-ddd:hh24:mi`"
  type        = string
  default     = "sat:10:00-sat:10:30"
}

variable "snapshot_copy" {
  description = "Configuration of automatic copy of snapshots from one region to another"
  type        = any
  default     = {}
}

variable "logging" {
  description = "Logging configuration for the cluster"
  type        = map(string)
  default     = {}
}

variable "cluster_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type        = map(string)
  default     = {}
}

################################################################################
# Paramter Group
################################################################################

variable "create_parameter_group" {
  description = "Determines whether to create a parameter group or use existing"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "The name of the Redshift parameter group, existing or to be created"
  type        = string
  default     = null
}

variable "parameter_group_description" {
  description = "The description of the Redshift parameter group. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "parameter_group_family" {
  description = "The family of the Redshift parameter group"
  type        = string
  default     = "redshift-1.0"
}

variable "parameter_group_parameters" {
  description = "value"
  type        = map(any)
  default     = {}
}

variable "parameter_group_tags" {
  description = "Additional tags to add to the parameter group"
  type        = map(string)
  default     = {}
}

################################################################################
# Subnet Group
################################################################################

variable "create_subnet_group" {
  description = "Determines whether to create a subnet group or use existing"
  type        = bool
  default     = true
}

variable "subnet_group_name" {
  description = "The name of the Redshift subnet group, existing or to be created"
  type        = string
  default     = null
}

variable "subnet_group_description" {
  description = "The description of the Redshift Subnet group. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "An array of VPC subnet IDs to use in the subnet group"
  type        = list(string)
  default     = []
}

variable "subnet_group_tags" {
  description = "Additional tags to add to the subnet group"
  type        = map(string)
  default     = {}
}

################################################################################
# Snapshot Schedule
################################################################################

variable "create_snapshot_schedule" {
  description = "Determines whether to create a snapshot schedule"
  type        = bool
  default     = false
}

variable "snapshot_schedule_identifier" {
  description = "The snapshot schedule identifier"
  type        = string
  default     = null
}

variable "use_snapshot_identifier_prefix" {
  description = "Determines whether the identifier (`snapshot_schedule_identifier`) is used as a prefix"
  type        = bool
  default     = true
}

variable "snapshot_schedule_description" {
  description = "The description of the snapshot schedule"
  type        = string
  default     = null
}

variable "snapshot_schedule_definitions" {
  description = "The definition of the snapshot schedule. The definition is made up of schedule expressions, for example `cron(30 12 *)` or `rate(12 hours)`"
  type        = list(string)
  default     = []
}

variable "snapshot_schedule_force_destroy" {
  description = "Whether to destroy all associated clusters with this snapshot schedule on deletion. Must be enabled and applied before attempting deletion"
  type        = bool
  default     = null
}

################################################################################
# Scheduled Action
################################################################################

variable "scheduled_actions" {
  description = "Map of maps containing scheduled action defintions"
  type        = any
  default     = {}
}

variable "create_scheduled_action_iam_role" {
  description = "Determines whether a scheduled action IAM role is created"
  type        = bool
  default     = false
}

variable "iam_role_name" {
  description = "Name to use on scheduled action IAM role created"
  type        = string
  default     = null
}

variable "iam_role_use_name_prefix" {
  description = "Determines whether scheduled action the IAM role name (`iam_role_name`) is used as a prefix"
  type        = string
  default     = true
}

variable "iam_role_path" {
  description = "Scheduled action IAM role path"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of the scheduled action IAM role"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the scheduled action IAM role"
  type        = string
  default     = null
}

variable "iam_role_tags" {
  description = "A map of additional tags to add to the scheduled action IAM role created"
  type        = map(string)
  default     = {}
}

################################################################################
# Usage Limit
################################################################################

varaible "usage_limits" {
  description = "Map of usage limit defintions to create"
  type        = any
  default     = {}
}

################################################################################
# Authentication Profile
################################################################################

variable "authentication_profiles" {
  description = "Map of authentication profiles to create"
  type        = any
  default     = {}
}

################################################################################
# HSM Client Certificate
################################################################################

variable "create_hsm_client_certificate" {
  description = "Determines whether to create a HSM client certificate"
  type        = bool
  default     = false
}

variable "hsm_client_certificate_identifier" {
  description = "The identifier of the HSM client certificate"
  type        = string
  default     = null
}
