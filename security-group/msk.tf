resource "aws_security_group" "msk_broker" {
  name        = "${var.vpc.name}-msk-broker-sg"
  vpc_id      = var.vpc.id
  description = "msk broker security group"

  tags = {
    Name = "msk-broker-sg"
  }
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
  from_port         = 9098
  to_port           = 9098
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_anywhere_msk_broker" {
  security_group_id = aws_security_group.msk_broker.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
