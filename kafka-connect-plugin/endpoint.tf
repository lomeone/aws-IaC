resource "aws_vpc_endpoint" "storage_gateway" {
  vpc_id             = var.vpc.id
  service_name       = "com.amazonaws.ap-northeast-2.storagegateway"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.vpc.subnet_ids
  security_group_ids = var.vpc.gateway_endpoint_security_groups
}
