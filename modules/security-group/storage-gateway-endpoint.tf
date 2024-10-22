resource "aws_security_group" "storage_gateway_endpoint" {
  vpc_id = var.vpc.id
  name   = "${var.vpc.name}-storage-gw-endpoint-sg"

  tags = {
    Name = "storage-gw-endpoint-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.storage_gateway_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.storage_gateway_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_storage_gateway_contol_port" {
  security_group_id = aws_security_group.storage_gateway_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 1026
  to_port           = 1028
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_storage_gateway_contol_port_sub" {
  security_group_id = aws_security_group.storage_gateway_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 1031
  to_port           = 1031
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_storage_gateway_metric" {
  security_group_id = aws_security_group.storage_gateway_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 2222
  to_port           = 2222
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_anywhere_s3_gw_endpoint" {
  security_group_id = aws_security_group.storage_gateway_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
