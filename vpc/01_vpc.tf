resource "aws_vpc" "lomeone-vpc" {
  cidr_block = var.cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.vpc.name}-vpc"
  }
}
