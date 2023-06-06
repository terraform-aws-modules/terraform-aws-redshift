################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The Redshift cluster ARN"
  value       = try(aws_redshift_cluster.this[0].arn, null)
}

output "cluster_id" {
  description = "The Redshift cluster ID"
  value       = try(aws_redshift_cluster.this[0].id, null)
}

output "cluster_identifier" {
  description = "The Redshift cluster identifier"
  value       = try(aws_redshift_cluster.this[0].cluster_identifier, null)
}

output "cluster_type" {
  description = "The Redshift cluster type"
  value       = try(aws_redshift_cluster.this[0].cluster_type, null)
}

output "cluster_node_type" {
  description = "The type of nodes in the cluster"
  value       = try(aws_redshift_cluster.this[0].node_type, null)
}

output "cluster_database_name" {
  description = "The name of the default database in the Cluster"
  value       = try(aws_redshift_cluster.this[0].database_name, null)
}

output "cluster_availability_zone" {
  description = "The availability zone of the Cluster"
  value       = try(aws_redshift_cluster.this[0].availability_zone, null)
}

output "cluster_automated_snapshot_retention_period" {
  description = "The backup retention period"
  value       = try(aws_redshift_cluster.this[0].automated_snapshot_retention_period, null)
}

output "cluster_preferred_maintenance_window" {
  description = "The backup window"
  value       = try(aws_redshift_cluster.this[0].preferred_maintenance_window, null)
}

output "cluster_endpoint" {
  description = "The connection endpoint"
  value       = try(aws_redshift_cluster.this[0].endpoint, null)
}

output "cluster_hostname" {
  description = "The hostname of the Redshift cluster"
  value = replace(
    try(aws_redshift_cluster.this[0].endpoint, ""),
    format(":%s", try(aws_redshift_cluster.this[0].port, "")),
    "",
  )
}

output "cluster_encrypted" {
  description = "Whether the data in the cluster is encrypted"
  value       = try(aws_redshift_cluster.this[0].encrypted, null)
}

output "cluster_vpc_security_group_ids" {
  description = "The VPC security group ids associated with the cluster"
  value       = try(aws_redshift_cluster.this[0].vpc_security_group_ids, [])
}

output "cluster_dns_name" {
  description = "The DNS name of the cluster"
  value       = try(aws_redshift_cluster.this[0].dns_name, null)
}

output "cluster_port" {
  description = "The port the cluster responds on"
  value       = try(aws_redshift_cluster.this[0].port, null)
}

output "cluster_version" {
  description = "The version of Redshift engine software"
  value       = try(aws_redshift_cluster.this[0].cluster_version, null)
}

output "cluster_parameter_group_name" {
  description = "The name of the parameter group to be associated with this cluster"
  value       = try(aws_redshift_cluster.this[0].cluster_parameter_group_name, null)
}

output "cluster_subnet_group_name" {
  description = "The name of a cluster subnet group to be associated with this cluster"
  value       = try(aws_redshift_cluster.this[0].cluster_subnet_group_name, null)
}

output "cluster_public_key" {
  description = "The public key for the cluster"
  value       = try(aws_redshift_cluster.this[0].cluster_public_key, null)
}

output "cluster_revision_number" {
  description = "The specific revision number of the database in the cluster"
  value       = try(aws_redshift_cluster.this[0].cluster_revision_number, null)
}

output "cluster_nodes" {
  description = "The nodes in the cluster. Each node is a map of the following attributes: `node_role`, `private_ip_address`, and `public_ip_address`"
  value       = try(aws_redshift_cluster.this[0].cluster_nodes, {})
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_arn" {
  description = "Amazon Resource Name (ARN) of the parameter group created"
  value       = try(aws_redshift_parameter_group.this[0].arn, null)
}

output "parameter_group_id" {
  description = "The name of the Redshift parameter group created"
  value       = try(aws_redshift_parameter_group.this[0].id, null)
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_arn" {
  description = "Amazon Resource Name (ARN) of the Redshift subnet group created"
  value       = try(aws_redshift_subnet_group.this[0].arn, null)
}

output "subnet_group_id" {
  description = "The ID of Redshift Subnet group created"
  value       = try(aws_redshift_subnet_group.this[0].id, null)
}

################################################################################
# Snapshot Schedule
################################################################################

output "snapshot_schedule_arn" {
  description = "Amazon Resource Name (ARN) of the Redshift Snapshot Schedule"
  value       = try(aws_redshift_snapshot_schedule.this[0].arn, null)
}

################################################################################
# Scheduled Action
################################################################################

output "scheduled_actions" {
  description = "A map of maps containing scheduled action details"
  value       = aws_redshift_scheduled_action.this
}

output "scheduled_action_iam_role_name" {
  description = "Scheduled actions IAM role name"
  value       = try(aws_iam_role.scheduled_action[0].name, null)
}

output "scheduled_action_iam_role_arn" {
  description = "Scheduled actions IAM role ARN"
  value       = try(aws_iam_role.scheduled_action[0].arn, null)
}

output "scheduled_action_iam_role_unique_id" {
  description = "Stable and unique string identifying the scheduled action IAM role"
  value       = try(aws_iam_role.scheduled_action[0].unique_id, null)
}

################################################################################
# Endpoint Access
################################################################################

output "endpoint_access_address" {
  description = "The DNS address of the endpoint"
  value       = try(aws_redshift_endpoint_access.this[0].address, null)
}

output "endpoint_access_id" {
  description = "The Redshift-managed VPC endpoint name"
  value       = try(aws_redshift_endpoint_access.this[0].id, null)
}

output "endpoint_access_port" {
  description = "The port number on which the cluster accepts incoming connections"
  value       = try(aws_redshift_endpoint_access.this[0].port, null)
}

output "endpoint_access_vpc_endpoint" {
  description = "The connection endpoint for connecting to an Amazon Redshift cluster through the proxy. See details below"
  value       = try(aws_redshift_endpoint_access.this[0].vpc_endpoint, null)
}

################################################################################
# Usage Limit
################################################################################

output "usage_limits" {
  description = "Map of usage limits created and their associated attributes"
  value       = aws_redshift_usage_limit.this
}

################################################################################
# Authentication Profile
################################################################################

output "authentication_profiles" {
  description = "Map of authentication profiles created and their associated attributes"
  value       = aws_redshift_authentication_profile.this
}
