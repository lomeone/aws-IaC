resource "aws_storagegateway_gateway" "main" {
  gateway_name         = var.name
  gateway_timezone     = "GMT+9:00"
  gateway_type         = "FILE_S3"
  gateway_ip_address   = aws_instance.storage_gateway.public_ip
  gateway_vpc_endpoint = aws_vpc_endpoint.storage_gateway.id
}

# data "aws_storagegateway_local_disk" "kafka_system" {
#   gateway_arn = aws_storagegateway_gateway.kafka_system.arn
# }

# resource "aws_storagegateway_cache" "kafka_system_gw_local_cache" {
#   gateway_arn = aws_storagegateway_gateway.kafka_system.arn
#   disk_id     = data.aws_storagegateway_local_disk.kafka_system.id
# }
