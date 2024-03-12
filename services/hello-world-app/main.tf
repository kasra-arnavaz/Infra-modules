terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "asg" {
  source        = "../../cluster/asg-rolling-deploy"
  name          = local.name
  ami           = var.ami
  instance_type = var.instance_type
  user_data = templatefile("${path.module}/user_data.sh", {
    server_port = var.server_port
    server_text = var.server_text
  })
  min_size          = var.min_size
  max_size          = var.max_size
  enable_scheduling = var.enable_scheduling
  subnet_ids        = local.subnet_ids
  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"
  server_port       = var.server_port
}

module "alb" {
  source     = "../../cluster/alb"
  name       = local.name
  subnet_ids = local.subnet_ids
}

resource "aws_lb_target_group" "asg" {
  name     = local.name
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = module.alb.alb_http_listner_arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

locals {
  name = "docker-app-${var.environment}"
}
