terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_db_instance" "books" {
  identifier_prefix      = "books"
  allocated_storage      = 10
  instance_class         = "db.t2.micro"
  skip_final_snapshot    = true
  publicly_accessible    = true
  engine                 = "mysql"
  vpc_security_group_ids = [module.vpc.id]
  username               = var.db_username
  password               = var.db_password
}

module "vpc" {
  source    = "../../networking/vpc"
  http_port = aws_db_instance.books.port
}
