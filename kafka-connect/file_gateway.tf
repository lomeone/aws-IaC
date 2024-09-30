resource "aws_storagegateway_gateway" "s3_file_gateway" {
  gateway_ip_address = aws_instance.gateway_instance.public_ip
  gateway_name       = var.name.gateway
  gateway_timezone   = "GMT"
  gateway_type       = "FILE_S3"
}

resource "aws_storagegateway_nfs_file_share" "nfs" {
  client_list  = var.file_share_clients
  gateway_arn  = aws_storagegateway_gateway.s3_file_gateway.arn
  location_arn = aws_s3_bucket.kafka_connect_plugin.arn
  role_arn     = aws_iam_role.storage_gateway.arn
}
