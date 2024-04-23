resource "aws_redshift_cluster" "mycluster" {
  cluster_identifier = var.cluster_identifier
  database_name      = var.database_name
  master_username    = var.username
  master_password    = random_password.password.result
  node_type          = var.nodetype
  cluster_type       = var.cluster_type
  #cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_group.id
  cluster_parameter_group_name = aws_redshift_parameter_group.MyRSParameter.id
  skip_final_snapshot = true
  publicly_accessible = true
  #elastic_ip          = aws_eip.myeip.public_ip
  #vpc_security_group_ids = [ aws_security_group.redshift_sg.id ]
  
  logging {
    enable        = false
    #bucket_name   = "my-s3-log-bucket"
    #s3_key_prefix = "example/"
  }

  depends_on = [
  #  aws_vpc.myvpc,
  #  aws_security_group.redshift_sg,
  #  aws_redshift_subnet_group.redshift_subnet_group,
  #  aws_iam_role.myredshiftROLE
  ]
}

resource "aws_redshift_cluster_iam_roles" "redshift-access" {
  cluster_identifier = aws_redshift_cluster.mycluster.cluster_identifier
  iam_role_arns      = [aws_iam_role.myredshiftROLE.arn]
}

resource "aws_redshift_parameter_group" "MyRSParameter" {
  name   = "redshift-terraform"
  family = "redshift-1.0"

  # parameter {
  #   name  = "require_ssl"
  #   value = "true"
  # }

  parameter {
    name  = "enable_user_activity_logging"
    value = "true"
  }

  parameter {
    name = "search_path"
    value = "$user, public, ${var.database_name}"
  }
}