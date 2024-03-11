terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_security_group" "allow_inbound" {
  name = var.name
  ingress {
    from_port   = var.inbound_port
    to_port     = var.inbound_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  lifecycle {
    create_before_destroy = true
  }
}

