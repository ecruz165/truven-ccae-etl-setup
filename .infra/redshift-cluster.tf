#############################
## Redshift Cluster - Main ##
#############################

# Create the Redshift Cluster
resource "aws_redshift_cluster" "redshift-cluster" {
  depends_on = [
    aws_redshift_subnet_group.redshift-subnet-group,
    aws_iam_role.redshift-role,
    aws_security_group.redshift_security_group
  ]

  cluster_identifier = var.redshift_cluster_identifier
  database_name      = var.redshift_database_name
  master_username    = var.redshift_admin_username
  master_password    = var.redshift_admin_password
  node_type          = var.redshift_node_type
  cluster_type       = var.redshift_cluster_type
  number_of_nodes    = var.redshift_number_of_nodes

  iam_roles = [aws_iam_role.redshift-role.arn]

  vpc_security_group_ids = [aws_security_group.redshift_security_group.id]

  cluster_subnet_group_name = aws_redshift_subnet_group.redshift-subnet-group.id
  
  skip_final_snapshot = true

  tags = {
    Name        = "${var.app_name}-${var.app_environment}-redshift-cluster"
    Environment = var.app_environment
  }
}