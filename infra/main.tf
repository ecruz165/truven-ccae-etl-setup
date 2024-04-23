terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  
  region     = var.region
  profile = "truven"
  default_tags {
    tags = {

      Owner   = "HardikPatel"
      Project = "RedshiftDemo"
    }
  }
}

resource "random_string" "unique_suffix" {
  length  = 6
  special = false
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!$%&*()-_=+[]{}<>:?"
}