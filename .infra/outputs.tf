###########################
## Redshift IAM - Output ##
###########################

output "redshift_iam_role_arn" {
  description = "Redshift IAM Role"
  value       = aws_iam_role.redshift-role.arn
}

#############################
## Security Group - Output ##
#############################

# output "redshift_security_group_id" {
#   description = "Redshift Security Group"
#   value       = aws_default_security_group.redshift_security_group.id
# }

###############################
## Redshift Cluster - Output ##
###############################

output "redshift_cluster_id" {
  description = "Redshift Cluster ID"
  value       = aws_redshift_cluster.redshift-cluster.id
}

output "redshift_cluster_dns_name" {
  description = "Redshift Cluster DNS Name"
  value       = aws_redshift_cluster.redshift-cluster.dns_name
}