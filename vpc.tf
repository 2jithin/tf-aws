# VPC tf code only
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  # enable_classiclink   = "false"

  tags = {
    Name = "vpc-${var.project}_${local.unique_stage}"
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}
