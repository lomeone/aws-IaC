resource "aws_security_group" "msk_broker" {
  vpc_id = var.vpc
  name   = var.name.security_group
}

resource "aws_vpc_security_group_ingress_rule" "allow_msk_plaintext" {
  security_group_id = aws_security_group.msk_broker.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 9092
  to_port           = 9092
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_msk_tls" {
  security_group_id = aws_security_group.msk_broker.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 9094
  to_port           = 9094
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_anyware" {
  security_group_id = aws_security_group.msk_broker.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
