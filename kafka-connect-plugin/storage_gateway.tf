resource "aws_storagegateway_gateway" "s3_file_gateway" {
  gateway_name     = var.name.gateway
  gateway_timezone = "GMT"
  gateway_type     = "FILE_S3"
}

resource "aws_storagegateway_nfs_file_share" "nfs" {
  client_list  = var.nfs_clients
  gateway_arn  = aws_storagegateway_gateway.s3_file_gateway.arn
  location_arn = aws_s3_bucket.kafka_connect_pulgin.arn
  role_arn     = aws_iam_role.storagegateway_bucket_access.arn

  cache_attributes {
    cache_stale_timeout_in_seconds = 300
  }
}
