resource "aws_security_group" "msk_security_group" {
  vpc_id = var.vpc
  name = var.name.security_group
}
