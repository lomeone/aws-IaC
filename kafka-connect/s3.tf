resource "aws_s3_bucket" "kafka_connect_plugin" {
  bucket = "kafka-connect-storage"

  tags = {
    Name = "${var.name.s3}"
  }
}
