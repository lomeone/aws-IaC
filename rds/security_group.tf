resource "aws_security_group" "rds_mysql" {
  name   = "rds-mysql"
  vpc_id = var.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql" {
  security_group_id = aws_security_group.rds_mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_anyware" {
  security_group_id = aws_security_group.rds_mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
