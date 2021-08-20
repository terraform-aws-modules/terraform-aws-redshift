output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.sg.security_group_id
}

output "redshift_cluster_id" {
  description = "The availability zone of the RDS instance"
  value       = module.redshift.redshift_cluster_id
}

output "redshift_cluster_endpoint" {
  description = "Redshift endpoint"
  value       = module.redshift.redshift_cluster_endpoint
}

output "redshift_cluster_hostname" {
  description = "Redshift hostname"
  value       = module.redshift.redshift_cluster_hostname
}

output "redshift_cluster_port" {
  description = "Redshift port"
  value       = module.redshift.redshift_cluster_port
}
