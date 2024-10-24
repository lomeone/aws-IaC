output "sg_id" {
  value = {
    mysql              = aws_security_group.mysql.id
    msk                = aws_security_group.msk_broker.id
    s3_storage_gateway = aws_security_group.s3_stroage_gateway.id
  }
}
