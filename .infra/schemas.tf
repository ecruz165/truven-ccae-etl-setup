resource "null_resource" "redshift_schema_vocab" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "psql -h ${aws_redshift_cluster.redshift-cluster.dns_name} -U ${var.redshift_admin_username} -d ${var.redshift_database_name} -f ../.sql/schemas.sql"
    environment = {
      PGPASSWORD = var.redshift_admin_password
    }
  }

  depends_on = [aws_redshift_cluster.redshift-cluster]
}
