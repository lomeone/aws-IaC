resource "aws_s3_bucket" "kafka_connect_pulgin" {
  bucket = var.name.s3
}
