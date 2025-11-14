variable "create" {
  description = "Determines whether to create Redshift cluster and resources (affects all resources)"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
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
  type = object({
    bucket_name          = optional(string)
    log_destination_type = optional(string)
    log_exports          = optional(list(string))
    s3_key_prefix        = optional(string)
  })
  default = null
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

variable "manage_master_password" {
  description = "Whether to use AWS SecretsManager to manage the cluster admin credentials. Conflicts with `master_password`. One of `master_password` or `manage_master_password` is required unless `snapshot_identifier` is provided"
  type        = bool
  default     = false
}

variable "master_password_secret_kms_key_id" {
  description = "ID of the KMS key used to encrypt the cluster admin credentials secret"
  type        = string
  default     = null
}

variable "master_password" {
  description = "Password for the master DB user. (Required unless a `snapshot_identifier` is provided). Must contain at least 8 chars, one uppercase letter, one lowercase letter, and one number"
  type        = string
  default     = null
  sensitive   = true
}

variable "multi_az" {
  description = "Specifies if the Redshift cluster is multi-AZ"
  type        = bool
  default     = null
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
  description = "The port number on which the cluster accepts incoming connections. Default port is `5439`"
  type        = number
  default     = 5439
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
  type = object({
    destination_region               = string
    manual_snapshot_retention_period = optional(number)
    retention_period                 = optional(number)
    grant_name                       = optional(string)
  })
  default = null
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
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
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
  default     = "redshift-2.0"
}

variable "parameter_group_parameters" {
  description = "A list of Redshift parameters to apply"
  type = list(object({
    name  = string
    value = string
  }))
  default = null
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

variable "snapshot_schedule" {
  description = "Configuration for creating a snapshot schedule and associating it with the cluster"
  type = object({
    definitions   = list(string)
    description   = optional(string)
    force_destroy = optional(bool)
    use_prefix    = optional(bool, false)
    identifier    = optional(string)
    tags          = optional(map(string), {})
  })
  default = null
}

################################################################################
# Scheduled Action
################################################################################

variable "scheduled_actions" {
  description = "Map of scheduled action definitions to create"
  type = map(object({
    name        = optional(string) # Will fall back to key if not set
    description = optional(string)
    enable      = optional(bool)
    start_time  = optional(string)
    end_time    = optional(string)
    schedule    = string
    iam_role    = optional(string)
    target_action = object({
      pause_cluster = optional(bool, false)
      resize_cluster = optional(object({
        classic         = optional(bool)
        cluster_type    = optional(string)
        node_type       = optional(string)
        number_of_nodes = optional(number)
      }))
      resume_cluster = optional(bool, false)
    })
  }))
  default  = {}
  nullable = false
}

################################################################################
# Scheduled Action IAM Role
################################################################################

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

variable "endpoint_access" {
  description = "Map of endpoint access (managed VPC endpoint) definitions to create"
  type = map(object({
    name                   = optional(string) # Will fall back to key if not set
    resource_owner         = optional(string)
    subnet_group_name      = string
    vpc_security_group_ids = optional(list(string))
  }))
  default  = {}
  nullable = false
}

################################################################################
# Usage Limit
################################################################################

variable "usage_limits" {
  description = "Map of usage limit definitions to create"
  type = map(object({
    amount        = number
    breach_action = optional(string)
    feature_type  = string
    limit_type    = optional(string) # Will fall back to key if not set
    period        = optional(string)
    tags          = optional(map(string), {})
  }))
  default  = {}
  nullable = false
}

################################################################################
# Authentication Profile
################################################################################

variable "authentication_profiles" {
  description = "Map of authentication profiles to create"
  type = map(object({
    name    = optional(string) # Will fall back to key if not set
    content = any
  }))
  default  = {}
  nullable = false
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a CloudWatch log group is created for each `var.logging.log_exports`"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain CloudWatch logs for the redshift cluster"
  type        = number
  default     = 0
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_skip_destroy" {
  description = "Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state"
  type        = bool
  default     = null
}

variable "cloudwatch_log_group_tags" {
  description = "Additional tags to add to cloudwatch log groups created"
  type        = map(string)
  default     = {}
}

################################################################################
# Managed Secret Rotation
################################################################################

variable "manage_master_password_rotation" {
  description = "Whether to manage the master user password rotation. Setting this value to false after previously having been set to true will disable automatic rotation"
  type        = bool
  default     = false
}

variable "master_password_rotate_immediately" {
  description = "Specifies whether to rotate the secret immediately or wait until the next scheduled rotation window"
  type        = bool
  default     = null
}

variable "master_password_rotation_automatically_after_days" {
  description = "Specifies the number of days between automatic scheduled rotations of the secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified"
  type        = number
  default     = null
}

variable "master_password_rotation_duration" {
  description = "The length of the rotation window in hours. For example, 3h for a three hour window"
  type        = string
  default     = null
}

variable "master_password_rotation_schedule_expression" {
  description = "A cron() or rate() expression that defines the schedule for rotating your secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified"
  type        = string
  default     = null
}

################################################################################
# Security Group
################################################################################

variable "create_security_group" {
  description = "Determines whether to create security group for Redshift cluster"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "The security group name"
  type        = string
  default     = ""
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`security_group_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "The description of the security group. If value is set to empty string it will contain cluster name in the description"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}

variable "security_group_ingress_rules" {
  description = "Map of security group ingress rules to add to the security group created"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    region                       = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default  = {}
  nullable = false
}

variable "security_group_egress_rules" {
  description = "Map of security group egress rules to add to the security group created"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    region                       = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default  = {}
  nullable = false
}

variable "security_group_tags" {
  description = "Additional tags for the security group"
  type        = map(string)
  default     = {}
}
