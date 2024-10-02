resource "aws_security_group" "s3_stroage_gateway" {
  vpc_id = var.vpc_id
  name   = var.name.security_group
}

resource "aws_vpc_security_group_ingress_rule" "allow_nfs_111_tcp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 111
  to_port           = 111
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_nfs_111_udp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 111
  to_port           = 111
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_nfs_2049_tcp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 2049
  to_port           = 2049
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_nfs_2049_udp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 2049
  to_port           = 2049
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_nfs_200048_tcp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 20048
  to_port           = 20048
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_nfs_20048_udp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 20048
  to_port           = 20048
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_smb_139_tcp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 139
  to_port           = 139
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_smb_139_udp" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 139
  to_port           = 139
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_smb_455" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 455
  to_port           = 455
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_ingress_rule" "allow_sgw_activation" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_anyware" {
  security_group_id = aws_security_group.s3_stroage_gateway.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "storage_gateway_endpoint" {
  vpc_id = var.vpc_id
  name   = "storage-gateway-endpoint-sg"
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

resource "aws_vpc_security_group_egress_rule" "allow_anyware_storage_gateway" {
  security_group_id = aws_security_group.storage_gateway_endpoint.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}