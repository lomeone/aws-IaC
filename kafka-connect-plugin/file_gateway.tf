resource "aws_storagegateway_gateway" "s3_file_gateway" {
  gateway_name     = var.name.gateway
  gateway_timezone = "GMT"
  gateway_type     = "FILE_S3"
}

resource "aws_storagegateway_nfs_file_share" "nfs" {
  gateway_arn = aws_storagegateway_gateway.s3_file_gateway.arn
  location_arn = 
}
