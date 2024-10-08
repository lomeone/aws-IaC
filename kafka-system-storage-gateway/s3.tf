resource "aws_s3_bucket" "kafka_system" {
  bucket = var.name.s3
}

resource "aws_s3_bucket_versioning" "kafka_system" {
  bucket = aws_s3_bucket.kafka_system.id

  versioning_configuration {
    status = "Enabled"
  }
}
