resource "aws_security_group" "mysql" {
  name        = "${var.vpc.name}-mysql-sg"
  vpc_id      = var.vpc.id
  description = "mysql security group"

  tags = {
    Name = "mysql-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql" {
  security_group_id = aws_security_group.mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_anywhere_mysql" {
  security_group_id = aws_security_group.mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
