##############################
## AWS Provider - Variables ##
##############################

# AWS connection & authentication

variable "aws_region" {
  type        = string
  description = "AWS region"
}

#############################
## Application - Variables ##
#############################

# Application definition

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_environment" {
  type        = string
  description = "Application environment"
}

#########################
## Network - Variables ##
#########################

# Network configuration

# variable "redshift_vpc_cidr" {
#   type        = string
#   description = "VPC IPv4 CIDR"
# }
variable "redshift_vpc_id" {
  type        = string
  description = "VPC_ID that redshift should be created in"
}

variable "redshift_security_group_id" {
  type        = string
  description = "VPC_ID that redshift should be created in"
}

##################################
## Redshift Cluster - Variables ##
##################################

variable "redshift_cluster_identifier" {
  type        = string
  description = "Redshift Cluster Identifier"
}

variable "redshift_database_name" { 
  type        = string
  description = "Redshift Database Name"
}

variable "redshift_admin_username" {
  type        = string
  description = "Redshift Admin Username"
}

variable "redshift_admin_password" { 
  type        = string
  description = "Redshift Admin Password"
}

variable "redshift_node_type" { 
  type        = string
  description = "Redshift Node Type"
  default     = "dc2.large"
}

variable "redshift_cluster_type" { 
  type        = string
  description = "Redshift Cluster Type"
  default     = "single-node"  // options are single-node or multi-node
}

variable "redshift_number_of_nodes" {
  type        = number
  description = "Redshift Number of Nodes in the Cluster"
  default     = 1
}
