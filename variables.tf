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

variable "allow_version_upgrade" {
  description = "If `true`, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default is `true`"
  type        = bool
  default     = null
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = null
}

variable "aqua_configuration_status" {
  description = "The value represents how the cluster is configured to use AQUA (Advanced Query Accelerator) after the cluster is restored. Possible values are `enabled`, `disabled`, and `auto`. Requires Cluster reboot"
  type        = string
  default     = null
}

variable "automated_snapshot_retention_period" {
  description = "The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Even if automated snapshots are disabled, you can still create manual snapshots when you want with create-cluster-snapshot. Default is 1"
  type        = number
  default     = null
}

variable "availability_zone" {
  description = "The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster. Can only be changed if `availability_zone_relocation_enabled` is `true`"
  type        = string
  default     = null
}

variable "availability_zone_relocation_enabled" {
  description = "If `true`, the cluster can be relocated to another availability zone, either automatically by AWS or when requested. Default is `false`. Available for use on clusters from the RA3 instance family"
  type        = bool
  default     = null
}

variable "cluster_identifier" {
  description = "The Cluster Identifier. Must be a lower case string"
  type        = string
  default     = ""
}

# cluster_parameter_group_name -> see parameter group section
# cluster_subnet_group_name -> see subnet group section

variable "cluster_version" {
  description = "The version of the Amazon Redshift engine software that you want to deploy on the cluster. The version selected runs on all the nodes in the cluster"
  type        = string
  default     = null
}

variable "database_name" {
  description = "The name of the first database to be created when the cluster is created. If you do not provide a name, Amazon Redshift will create a default database called `dev`"
  type        = string
  default     = null
}

# default_iam_role_arn -> see iam roles section

variable "elastic_ip" {
  description = "The Elastic IP (EIP) address for the cluster"
  type        = string
  default     = null
}

variable "encrypted" {
  description = "If `true`, the data in the cluster is encrypted at rest"
  type        = bool
  default     = true
}

variable "enhanced_vpc_routing" {
  description = "If `true`, enhanced VPC routing is enabled"
  type        = bool
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, `skip_final_snapshot` must be `false`"
  type        = string
  default     = null
}

# iam_roles -> see iam roles section

variable "kms_key_arn" {
  description = "The ARN for the KMS encryption key. When specifying `kms_key_arn`, `encrypted` needs to be set to `true`"
  type        = string
  default     = null
}

variable "logging" {
  description = "Logging configuration for the cluster"
  type        = any
  default     = {}
}

variable "maintenance_track_name" {
  description = "The name of the maintenance track for the restored cluster. When you take a snapshot, the snapshot inherits the MaintenanceTrack value from the cluster. The snapshot might be on a different track than the cluster that was the source for the snapshot. Default value is `current`"
  type        = string
  default     = null
}

variable "manual_snapshot_retention_period" {
  description = "The default number of days to retain a manual snapshot. If the value is -1, the snapshot is retained indefinitely. This setting doesn't change the retention period of existing snapshots. Valid values are between `-1` and `3653`. Default value is `-1`"
  type        = number
  default     = null
}

variable "master_password" {
  description = "Password for the master DB user. (Required unless a `snapshot_identifier` is provided). Must contain at least 8 chars, one uppercase letter, one lowercase letter, and one number"
  type        = string
  default     = null
  sensitive   = true
}

variable "create_random_password" {
  description = "Determines whether to create random password for cluster `master_password`"
  type        = bool
  default     = true
}

variable "random_password_length" {
  description = "Length of random password to create. Defaults to `16`"
  type        = number
  default     = 16
}

variable "master_username" {
  description = "Username for the master DB user (Required unless a `snapshot_identifier` is provided). Defaults to `awsuser`"
  type        = string
  default     = "awsuser"
}

variable "node_type" {
  description = "The node type to be provisioned for the cluster"
  type        = string
  default     = ""
}

variable "number_of_nodes" {
  description = "Number of nodes in the cluster. Defaults to 1. Note: values greater than 1 will trigger `cluster_type` to switch to `multi-node`"
  type        = number
  default     = 1
}

variable "owner_account" {
  description = "The AWS customer account used to create or copy the snapshot. Required if you are restoring a snapshot you do not own, optional if you own the snapshot"
  type        = string
  default     = null
}

variable "port" {
  description = "The port number on which the cluster accepts incoming connections. Default port is 5439"
  type        = number
  default     = null
}

variable "preferred_maintenance_window" {
  description = "The weekly time range (in UTC) during which automated cluster maintenance can occur. Format: `ddd:hh24:mi-ddd:hh24:mi`"
  type        = string
  default     = "sat:10:00-sat:10:30"
}

variable "publicly_accessible" {
  description = "If true, the cluster can be accessed from a public network"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot of the cluster is created before Redshift deletes the cluster. If true, a final cluster snapshot is not created. If false , a final cluster snapshot is created before the cluster is deleted"
  type        = bool
  default     = true
}

variable "snapshot_cluster_identifier" {
  description = "The name of the cluster the source snapshot was created from"
  type        = string
  default     = null
}

variable "snapshot_copy" {
  description = "Configuration of automatic copy of snapshots from one region to another"
  type        = any
  default     = {}
}

variable "snapshot_identifier" {
  description = "The name of the snapshot from which to create the new cluster"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster"
  type        = list(string)
  default     = []
}

variable "cluster_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type        = map(string)
  default     = {}
}

################################################################################
# IAM Roles
################################################################################

variable "iam_role_arns" {
  description = "A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time"
  type        = list(string)
  default     = []
}

variable "default_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) for the IAM role that was set as default for the cluster when the cluster was created"
  type        = string
  default     = null
}

################################################################################
# Parameter Group
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
  description = "Map of maps containing scheduled action definitions"
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
# Endpoint Access
################################################################################

variable "create_endpoint_access" {
  description = "Determines whether to create an endpoint access (managed VPC endpoint)"
  type        = bool
  default     = false
}

variable "endpoint_name" {
  description = "The Redshift-managed VPC endpoint name"
  type        = string
  default     = ""
}

variable "endpoint_resource_owner" {
  description = "The Amazon Web Services account ID of the owner of the cluster. This is only required if the cluster is in another Amazon Web Services account"
  type        = string
  default     = null
}

variable "endpoint_subnet_group_name" {
  description = "The subnet group from which Amazon Redshift chooses the subnet to deploy the endpoint"
  type        = string
  default     = ""
}

variable "endpoint_vpc_security_group_ids" {
  description = "The security group IDs to use for the endpoint access (managed VPC endpoint)"
  type        = list(string)
  default     = []
}

################################################################################
# Usage Limit
################################################################################

variable "usage_limits" {
  description = "Map of usage limit definitions to create"
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
