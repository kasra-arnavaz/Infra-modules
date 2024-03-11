terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_security_group" "allow_inbound_outbound" {
  name = var.name
  ingress {
    from_port   = var.inbound_port
    to_port     = var.inbound_port
    protocol    = local.tcp_protocol
    cidr_blocks = var.cidr_blocks
  }
  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = var.cidr_blocks
  }
}

locals {
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
}

