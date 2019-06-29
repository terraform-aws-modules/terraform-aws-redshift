output "this_redshift_cluster_arn" {
  description = "The Redshift cluster ARN"
  value       = aws_redshift_cluster.this.arn
}

output "this_redshift_cluster_id" {
  description = "The Redshift cluster ID"
  value       = aws_redshift_cluster.this.id
}

output "this_redshift_cluster_identifier" {
  description = "The Redshift cluster identifier"
  value       = aws_redshift_cluster.this.cluster_identifier
}

output "this_redshift_cluster_type" {
  description = "The Redshift cluster type"
  value       = aws_redshift_cluster.this.cluster_type
}

output "this_redshift_cluster_node_type" {
  description = "The type of nodes in the cluster"
  value       = aws_redshift_cluster.this.node_type
}

output "this_redshift_cluster_database_name" {
  description = "The name of the default database in the Cluster"
  value       = aws_redshift_cluster.this.database_name
}

output "this_redshift_cluster_availability_zone" {
  description = "The availability zone of the Cluster"
  value       = aws_redshift_cluster.this.availability_zone
}

output "this_redshift_cluster_automated_snapshot_retention_period" {
  description = "The backup retention period"
  value       = aws_redshift_cluster.this.automated_snapshot_retention_period
}

output "this_redshift_cluster_preferred_maintenance_window" {
  description = "The backup window"
  value       = aws_redshift_cluster.this.preferred_maintenance_window
}

output "this_redshift_cluster_endpoint" {
  description = "The connection endpoint"
  value       = aws_redshift_cluster.this.endpoint
}

output "this_redshift_cluster_hostname" {
  description = "The hostname of the Redshift cluster"
  value = replace(
    aws_redshift_cluster.this.endpoint,
    format(":%s", aws_redshift_cluster.this.port),
    "",
  )
}

output "this_redshift_cluster_encrypted" {
  description = "Whether the data in the cluster is encrypted"
  value       = aws_redshift_cluster.this.encrypted
}

output "this_redshift_cluster_security_groups" {
  description = "The security groups associated with the cluster"
  value       = aws_redshift_cluster.this.cluster_security_groups
}

output "this_redshift_cluster_vpc_security_group_ids" {
  description = "The VPC security group ids associated with the cluster"
  value       = aws_redshift_cluster.this.vpc_security_group_ids
}

output "this_redshift_cluster_port" {
  description = "The port the cluster responds on"
  value       = aws_redshift_cluster.this.port
}

output "this_redshift_cluster_version" {
  description = "The version of Redshift engine software"
  value       = aws_redshift_cluster.this.cluster_version
}

output "this_redshift_cluster_parameter_group_name" {
  description = "The name of the parameter group to be associated with this cluster"
  value       = aws_redshift_cluster.this.cluster_parameter_group_name
}

output "this_redshift_cluster_subnet_group_name" {
  description = "The name of a cluster subnet group to be associated with this cluster"
  value       = aws_redshift_cluster.this.cluster_subnet_group_name
}

output "this_redshift_cluster_public_key" {
  description = "The public key for the cluster"
  value       = aws_redshift_cluster.this.cluster_public_key
}

output "this_redshift_cluster_revision_number" {
  description = "The specific revision number of the database in the cluster"
  value       = aws_redshift_cluster.this.cluster_revision_number
}

output "this_redshift_subnet_group_id" {
  description = "The ID of Redshift subnet group created by this module"
  value       = element(concat(aws_redshift_subnet_group.this.*.id, [""]), 0)
}

output "this_redshift_parameter_group_id" {
  description = "The ID of Redshift parameter group created by this module"
  value       = element(concat(aws_redshift_parameter_group.this.*.id, [""]), 0)
}
