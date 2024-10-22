resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = var.vpc.id
  service_name      = "com.amazonaws.ap-northeast-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = concat(var.route_table_ids.public, var.route_table_ids.private)

  tags = {
    Name = "${var.name.vpc}-s3-endpoint-gateway"
  }
}
