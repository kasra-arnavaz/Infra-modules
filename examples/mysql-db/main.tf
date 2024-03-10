terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source      = "../../data-stores/mysql"
  db_username = var.db_username
  db_password = var.db_password
}
