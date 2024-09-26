resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.name.internet_gateway
  }
}

resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  count  = length(var.subnet_cidr.public)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "public_nat_gateway" {
  count = length(var.subnet_cidr.public)

  allocation_id = aws_eip.nat_gateway_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name.vpc}-${var.name.public_nat_gateway}-${format("%02s", count.index)}-${local.az[count.index % var.availability_zone_count]}"
  }
}
