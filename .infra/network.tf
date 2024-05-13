####################
## Network - Main ##
####################

# AWS Availability Zones data
data "aws_availability_zones" "available" {}

# Data source to fetch all subnets in the specified VPC
data "aws_subnets" "available_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.redshift_vpc_id]
  }
}

# Create the Redshift Subnet Group
resource "aws_redshift_subnet_group" "redshift-subnet-group" {
  name       = "${var.app_name}-${var.app_environment}-redshift-subnet-group"
  subnet_ids = data.aws_subnets.available_subnets.ids  # Using fetched subnet IDs
  tags = {
    Name        = "${var.app_name}-${var.app_environment}-redshift-subnet-group"
    Environment = var.app_environment
  }
}
