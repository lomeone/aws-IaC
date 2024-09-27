resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name.vpc}-${var.name.public_route_table}"
  }
}

resource "aws_route_table" "eks_control_plane_route_table" {
  vpc_id = aws_vpc.main.id
  count  = length(var.subnet_cidr.public)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway[count.index].id
  }

  tags = {
    Name = "${var.name.vpc}-${var.name.eks_control_plane_route_table}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  count  = length(var.subnet_cidr.public)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway[count.index].id
  }

  tags = {
    Name = "${var.name.vpc}-${var.name.private_route_table}"
  }
}

resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name.vpc}-${var.name.db_route_table}"
  }
}
