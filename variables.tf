variable "cluster_identifier" {
  description = "Custom name of the cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of Redshift engine cluster"
  type        = string
  default     = "1.0"
  # Constraints: Only version 1.0 is currently available.
  # http://docs.aws.amazon.com/cli/latest/reference/redshift/create-cluster.html
}

variable "cluster_node_type" {
  description = "Node Type of Redshift cluster"
  type        = string
  # Valid Values: dc1.large | dc1.8xlarge | dc2.large | dc2.8xlarge | ds2.xlarge | ds2.8xlarge.
  # http://docs.aws.amazon.com/cli/latest/reference/redshift/create-cluster.html
}

variable "cluster_number_of_nodes" {
  description = "Number of nodes in the cluster (values greater than 1 will trigger 'cluster_type' of 'multi-node')"
  type        = number
  default     = 3
}

variable "cluster_database_name" {
  description = "The name of the database to create"
  type        = string
}

variable "cluster_master_username" {
  description = "Master username"
  type        = string
}

variable "cluster_master_password" {
  description = "Password for master user"
  type        = string
}

variable "cluster_port" {
  description = "Cluster port"
  type        = number
  default     = 5439
}

# This is for a custom parameter to be passed to the DB
# We're "cloning" default ones, but we need to specify which should be copied
variable "cluster_parameter_group" {
  description = "Parameter group, depends on DB engine used"
  type        = string
  default     = "redshift-1.0"
}

variable "cluster_iam_roles" {
  description = "A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time."
  type        = list(string)
  default     = []
}

variable "publicly_accessible" {
  description = "Determines if Cluster can be publicly available (NOT recommended)"
  type        = bool
  default     = false
}

variable "redshift_subnet_group_name" {
  description = "The name of a cluster subnet group to be associated with this cluster. If not specified, new subnet will be created."
  type        = string
  default     = ""
}

variable "parameter_group_name" {
  description = "The name of the parameter group to be associated with this cluster. If not specified new parameter group will be created."
  type        = string
  default     = ""
}

variable "subnets" {
  description = "List of subnets DB should be available at. It might be one subnet."
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster."
  type        = list(string)
}

variable "final_snapshot_identifier" {
  description = "(Optional) The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, 'skip_final_snapshot' must be false."
  type        = string
  default     = ""
}

variable "skip_final_snapshot" {
  description = "If true (default), no snapshot will be made before deleting DB"
  type        = bool
  default     = true
}

variable "preferred_maintenance_window" {
  description = "When AWS can run snapshot, can't overlap with maintenance window"
  type        = string
  default     = "sat:10:00-sat:10:30"
}

variable "automated_snapshot_retention_period" {
  description = "How long will we retain backups"
  type        = number
  default     = 0
}

variable "enable_logging" {
  description = "Enables logging information such as queries and connection attempts, for the specified Amazon Redshift cluster."
  type        = bool
  default     = false
}

variable "logging_bucket_name" {
  description = "(Optional, required when enable_logging is true) The name of an existing S3 bucket where the log files are to be stored. Must be in the same region as the cluster and the cluster must have read bucket and put object permissions."
  type        = string
  default     = null
}

variable "logging_s3_key_prefix" {
  description = "(Optional) The prefix applied to the log file names."
  type        = string
  default     = null
}

# parameter group config bits
# ref: https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html
variable "enable_user_activity_logging" {
  description = "Enable logging of user activity. See https://docs.aws.amazon.com/redshift/latest/mgmt/db-auditing.html"
  type        = string
  default     = "false"
}

variable "require_ssl" {
  description = "Require SSL to connect to this cluster"
  type        = string
  default     = "false"
}

variable "snapshot_identifier" {
  description = "(Optional) The name of the snapshot from which to create the new cluster."
  type        = string
  default     = null
}

variable "snapshot_cluster_identifier" {
  description = "(Optional) The name of the cluster the source snapshot was created from."
  type        = string
  default     = null
}

variable "snapshot_copy_destination_region" {
  description = "(Optional) The name of the region where the snapshot will be copied."
  type        = string
  default     = null
}

variable "owner_account" {
  description = "(Optional) The AWS customer account used to create or copy the snapshot. Required if you are restoring a snapshot you do not own, optional if you own the snapshot."
  type        = string
  default     = null
}

variable "use_fips_ssl" {
  description = "Enable FIPS-compliant SSL mode only if your system is required to be FIPS compliant."
  type        = string
  default     = "false"
}

variable "wlm_json_configuration" {
  description = "Configuration bits for WLM json. see https://docs.aws.amazon.com/redshift/latest/mgmt/workload-mgmt-config.html"
  type        = string
  default     = "[{\"query_concurrency\": 5}]"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "encrypted" {
  description = "(Optional) If true , the data in the cluster is encrypted at rest."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "(Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true."
  type        = string
  default     = ""
}

variable "enhanced_vpc_routing" {
  description = "(Optional) If true, enhanced VPC routing is enabled."
  type        = bool
  default     = false
}

variable "allow_version_upgrade" {
  description = "(Optional) If true, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster."
  type        = bool
  default     = true
}

variable "enable_case_sensitive_identifier" {
  description = "(Optional) A configuration value that determines whether name identifiers of databases, tables, and columns are case sensitive."
  type        = bool
  default     = false
}

variable "max_concurrency_scaling_clusters" {
  description = "(Optional) Max concurrency scaling clusters parameter (0 to 10)"
  type        = string
  default     = "1"
}
