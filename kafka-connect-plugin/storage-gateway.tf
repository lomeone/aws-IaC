resource "aws_storagegateway_gateway" "kafka_connect_plugin" {
  gateway_ip_address = aws_instance.storage_gateway.public_ip
  gateway_name       = var.name.gateway
  gateway_timezone   = "GMT+9:00"
  gateway_type       = "FILE_S3"
}

# data "aws_storagegateway_local_disk" "kafka_connect_plugin" {
#   gateway_arn = aws_storagegateway_gateway.kafka_connect_plugin.arn
# }

# resource "aws_storagegateway_cache" "kafka_connect_local_cache" {
#   gateway_arn = aws_storagegateway_gateway.kafka_connect_plugin.arn
#   disk_id     = data.aws_storagegateway_local_disk.kafka_connect_plugin.id
# }

resource "aws_storagegateway_nfs_file_share" "nfs" {
  client_list  = var.storage_gateway.nfs_clients
  gateway_arn  = aws_storagegateway_gateway.kafka_connect_plugin.arn
  location_arn = aws_s3_bucket.kafka_connect_plugin.arn
  role_arn     = aws_iam_role.storagegateway_bucket_access.arn

  cache_attributes {
    cache_stale_timeout_in_seconds = 300
  }
}