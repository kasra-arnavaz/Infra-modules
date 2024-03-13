data "aws_vpc" "default" {
  count   = var.vpc_id == null ? 1 : 0
  default = true
}

data "aws_subnets" "default" {
  count = var.subnet_ids == null ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}

locals {
  vpc_id     = (var.vpc_id == null ? data.aws_vpc.default[0].id : var.vpc_id)
  subnet_ids = (var.subnet_ids == null ? data.aws_subnets.default[0].ids : var.subnet_ids)
}
