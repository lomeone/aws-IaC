resource "aws_vpc_endpoint" "storage_gateway" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.ap-northeast-2.storagegateway"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.vpc_endpoint_subnet
  security_group_ids = [aws_security_group.storage_gateway_endpoint.id]
}
