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

module "asg" {
  source             = "../../cluster/asg-rolling-deploy"
  cluster_name       = "one-instance-example"
  ami                = data.aws_ami.ubuntu.id
  instance_type      = "t2.micro"
  min_size           = 1
  max_size           = 1
  enable_scheduling  = false
  subnet_ids         = data.aws_subnets.default.ids
  security_group_ids = [module.one_instance_security_group.id]
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_vpc" "default" {
  default = true
}

module "one_instance_security_group" {
  source       = "../../networking/security-group/allow-inbound"
  name         = "one-instance-security-group"
  inbound_port = 22
}
