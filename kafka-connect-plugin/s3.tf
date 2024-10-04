resource "aws_s3_bucket" "kafka_connect_plugin" {
  bucket = var.name.s3
}
