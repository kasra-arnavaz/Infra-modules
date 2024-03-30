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
  identifier_prefix       = local.name
  allocated_storage       = 10
  instance_class          = "db.t3.micro"
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.mysql.id]
  backup_retention_period = var.backup_retention_period
  # If specified, this DB will be a replica
  replicate_source_db = var.replicate_source_db
  # Only set these for the primary DB
  engine   = var.replicate_source_db == null ? "mysql" : null
  db_name  = var.replicate_source_db == null ? var.db_name : null
  username = var.replicate_source_db == null ? var.db_username : null
  password = var.replicate_source_db == null ? var.db_password : null
  # Run a script locally to create a table
  provisioner "local-exec" {
    command = var.replicate_source_db == null ? templatefile("${path.module}/local-exec.sh", {
      db_name  = self.db_name
      sql_file = "${path.module}/table.sql"
      address  = self.address
      port     = self.port
      username = var.db_username
      password = var.db_password
    }) : ":"
  }
}

resource "aws_security_group" "mysql" {
  name   = "${local.name}-sg"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_sql_inbound" {
  type              = "ingress"
  from_port         = local.mysql_port
  to_port           = local.mysql_port
  protocol          = local.tcp_protocol
  cidr_blocks       = local.all_ips
  security_group_id = aws_security_group.mysql.id
}
resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = local.any_port
  to_port           = local.any_port
  protocol          = local.any_protocol
  cidr_blocks       = local.all_ips
  security_group_id = aws_security_group.mysql.id
}

locals {
  mysql_port   = 3306
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
  name         = "${var.name}-${var.env_name}"
}
