terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix      = local.name
  allocated_storage      = 10
  instance_class         = "db.t2.micro"
  skip_final_snapshot    = true
  engine                 = "mysql"
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.mysql.id]
  username               = var.db_username
  password               = var.db_password
}

resource "aws_security_group" "mysql" {
  name   = "${local.name}-sg"
  vpc_id = data.aws_vpc.default.id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_mysql_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.mysql.id
  from_port         = local.mysql_port
  to_port           = local.mysql_port
  protocol          = local.tcp_protocol
  cidr_blocks       = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.mysql.id
  from_port         = local.any_port
  to_port           = local.any_port
  protocol          = local.any_protocol
  cidr_blocks       = local.all_ips
}

locals {
  mysql_port   = 3306
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
  name         = "${var.name}-${var.env_name}"
}

data "aws_vpc" "default" {
  default = true
}
