################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The Redshift cluster ARN"
  value       = module.redshift.cluster_arn
}

output "cluster_id" {
  description = "The Redshift cluster ID"
  value       = module.redshift.cluster_id
}

output "cluster_identifier" {
  description = "The Redshift cluster identifier"
  value       = module.redshift.cluster_identifier
}

output "cluster_type" {
  description = "The Redshift cluster type"
  value       = module.redshift.cluster_type
}

output "cluster_node_type" {
  description = "The type of nodes in the cluster"
  value       = module.redshift.cluster_node_type
}

output "cluster_database_name" {
  description = "The name of the default database in the Cluster"
  value       = module.redshift.cluster_database_name
}

output "cluster_availability_zone" {
  description = "The availability zone of the Cluster"
  value       = module.redshift.cluster_availability_zone
}

output "cluster_automated_snapshot_retention_period" {
  description = "The backup retention period"
  value       = module.redshift.cluster_automated_snapshot_retention_period
}

output "cluster_preferred_maintenance_window" {
  description = "The backup window"
  value       = module.redshift.cluster_preferred_maintenance_window
}

output "cluster_endpoint" {
  description = "The connection endpoint"
  value       = module.redshift.cluster_endpoint
}

output "cluster_hostname" {
  description = "The hostname of the Redshift cluster"
  value       = module.redshift.cluster_hostname
}

output "cluster_encrypted" {
  description = "Whether the data in the cluster is encrypted"
  value       = module.redshift.cluster_encrypted
}

output "cluster_security_groups" {
  description = "The security groups associated with the cluster"
  value       = module.redshift.cluster_security_groups
}

output "cluster_vpc_security_group_ids" {
  description = "The VPC security group ids associated with the cluster"
  value       = module.redshift.cluster_vpc_security_group_ids
}

output "cluster_port" {
  description = "The port the cluster responds on"
  value       = module.redshift.cluster_port
}

output "cluster_version" {
  description = "The version of Redshift engine software"
  value       = module.redshift.cluster_version
}

output "cluster_parameter_group_name" {
  description = "The name of the parameter group to be associated with this cluster"
  value       = module.redshift.cluster_parameter_group_name
}

output "cluster_subnet_group_name" {
  description = "The name of a cluster subnet group to be associated with this cluster"
  value       = module.redshift.cluster_subnet_group_name
}

output "cluster_public_key" {
  description = "The public key for the cluster"
  value       = module.redshift.cluster_public_key
}

output "cluster_revision_number" {
  description = "The specific revision number of the database in the cluster"
  value       = module.redshift.cluster_revision_number
}

output "cluster_nodes" {
  description = "The nodes in the cluster. Each node is a map of the following attributes: `node_role`, `private_ip_address`, and `public_ip_address`"
  value       = module.redshift.cluster_nodes
}

################################################################################
# Paramter Group
################################################################################

output "parameter_group_arn" {
  description = "Amazon Resource Name (ARN) of the parameter group created"
  value       = module.redshift.parameter_group_arn
}

output "parameter_group_id" {
  description = "The name of the Redshift parameter group created"
  value       = module.redshift.parameter_group_id
}

################################################################################
# Paramter Group
################################################################################

output "subnet_group_arn" {
  description = "Amazon Resource Name (ARN) of the Redshift subnet group created"
  value       = module.redshift.subnet_group_arn
}

output "subnet_group_id" {
  description = "The ID of Redshift Subnet group created"
  value       = module.redshift.subnet_group_id
}

################################################################################
# Snapshot Schedule
################################################################################

output "snapshot_schedule_arn" {
  description = "Amazon Resource Name (ARN) of the Redshift Snapshot Schedule"
  value       = module.redshift.snapshot_schedule_arn
}

################################################################################
# Scheduled Action
################################################################################

output "scheduled_actions" {
  description = "A map of maps containing scheduled action details"
  value       = module.redshift.scheduled_actions
}

output "scheduled_action_iam_role_name" {
  description = "Scheduled actions IAM role name"
  value       = module.redshift.scheduled_action_iam_role_name
}

output "scheduled_action_iam_role_arn" {
  description = "Scheduled actions IAM role ARN"
  value       = module.redshift.scheduled_action_iam_role_arn
}

output "scheduled_action_iam_role_unique_id" {
  description = "Stable and unique string identifying the scheduled action IAM role"
  value       = module.redshift.scheduled_action_iam_role_unique_id
}

################################################################################
# Usage Limit
################################################################################

output "usage_limits" {
  description = "Map of usage limits created and their associated attributes"
  value       = module.redshift.usage_limits
}

################################################################################
# Authentication Profile
################################################################################

output "authentication_profiles" {
  description = "Map of authentication profiles created and their associated attributes"
  value       = module.redshift.authentication_profiles
}

################################################################################
# HSM Client Certificate
################################################################################

output "hsm_client_certificate_arn" {
  description = "Amazon Resource Name (ARN) of the HSM client certificate"
  value       = module.redshift.hsm_client_certificate_arn
}

output "hsm_client_certificate_public_key" {
  description = "The public key that the Amazon Redshift cluster will use to connect to the HSM. You must register the public key in the HSM"
  value       = module.redshift.hsm_client_certificate_public_key
}
