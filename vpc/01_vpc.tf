data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az = data.aws_availability_zones.available.names
  subnet = {
    "public"  = [for i in [10, 20] : cidrsubnet(var.cidr, 8, i)]
    "private" = [for i in [30, 40] : cidrsubnet(var.cidr, 8, 1)]
  }
}

resource "aws_vpc" "lomeone-vpc" {
  cidr_block = var.cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/role/internal-elb" = 1
    Name                              = "${var.name}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id   = aws_vpc.lomeone-vpc.id
  for_each = toset(local.subnet.public)

  cidr_block        = each.value
  availability_zone = local.az[index(local.subnet.public, each.value)]
}
