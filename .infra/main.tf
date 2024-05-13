terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  profile = "truven"
  default_tags {
    tags = {
      Owner   = "EdwinCruz"
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
