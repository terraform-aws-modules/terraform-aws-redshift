output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "this_security_group_id" {
  description = "The ID of the security group"
  value       = module.sg.this_security_group_id
}

output "this_redshift_cluster_id" {
  description = "The availability zone of the RDS instance"
  value       = module.redshift.this_redshift_cluster_id
}

output "this_redshift_cluster_endpoint" {
  description = "Redshift endpoint"
  value       = module.redshift.this_redshift_cluster_endpoint
}

output "this_redshift_cluster_hostname" {
  description = "Redshift hostname"
  value       = module.redshift.this_redshift_cluster_hostname
}

output "this_redshift_cluster_port" {
  description = "Redshift port"
  value       = module.redshift.this_redshift_cluster_port
}
