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

module "mysql_example" {
  source                = "../../data-stores/mysql"
  db_username           = var.db_username
  db_password           = var.db_password
  db_security_group_ids = [module.db_security_group_example.id]
}

module "db_security_group_example" {
  source    = "../../networking/security-group"
  http_port = 5000
}

