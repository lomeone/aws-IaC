resource "aws_storagegateway_gateway" "kafka_system" {
  gateway_ip_address = aws_instance.storage_gateway.public_ip
  gateway_name       = var.name.gateway
  gateway_timezone   = "GMT+9:00"
  gateway_type       = "FILE_S3"
}

# data "aws_storagegateway_local_disk" "kafka_system" {
#   gateway_arn = aws_storagegateway_gateway.kafka_system.arn
# }

# resource "aws_storagegateway_cache" "kafka_system_gw_local_cache" {
#   gateway_arn = aws_storagegateway_gateway.kafka_system.arn
#   disk_id     = data.aws_storagegateway_local_disk.kafka_system.id
# }

resource "aws_storagegateway_nfs_file_share" "plugin" {
  client_list     = var.storage_gateway.nfs_clients
  gateway_arn     = aws_storagegateway_gateway.kafka_system.arn
  location_arn    = "${aws_s3_bucket.kafka_system.arn}/plugin/"
  role_arn        = aws_iam_role.storagegateway_bucket_access.arn
  file_share_name = "kafka-system-plugin"

  cache_attributes {
    cache_stale_timeout_in_seconds = 300
  }
}

resource "aws_storagegateway_nfs_file_share" "redpanda" {
  client_list     = var.storage_gateway.nfs_clients
  gateway_arn     = aws_storagegateway_gateway.kafka_system.arn
  location_arn    = "${aws_s3_bucket.kafka_system.arn}/redpanda/"
  role_arn        = aws_iam_role.storagegateway_bucket_access.arn
  file_share_name = "kafka-system-redpanda"

  cache_attributes {
    cache_stale_timeout_in_seconds = 300
  }
}

resource "aws_storagegateway_nfs_file_share" "msk_auth" {
  client_list     = var.storage_gateway.nfs_clients
  gateway_arn     = aws_storagegateway_gateway.kafka_system.arn
  location_arn    = "${aws_s3_bucket.kafka_system.arn}/msk-auth/"
  role_arn        = aws_iam_role.storagegateway_bucket_access.arn
  file_share_name = "kafka-system-msk-auth"

  cache_attributes {
    cache_stale_timeout_in_seconds = 300
  }
}
