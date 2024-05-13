###########################
## Security Group - Main ##
###########################

#Create a VPC Default Security Group for Redshift
resource "aws_security_group" "redshift_security_group" {
  vpc_id         = var.redshift_vpc_id
  
  ingress {
    description = "Allow Redshift from VPN subnet"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.144.220.0/25"]  // Adjusted to your VPN subnet
  }
  
  tags = {
    Name        = "${var.app_name}-${var.app_environment}-redshift-security-group"
    Environment = var.app_environment
  }
}
