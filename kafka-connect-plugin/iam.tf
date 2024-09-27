resource "aws_iam_role" "storagegateway_bucket_access" {
  name = var.name.iam_role
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketLocation",
          "s3:GetBucketVersioning",
          "s3:ListBucket",
          "s3:ListBucketVersions",
          "s3:ListBucketMultipartUploads"
        ],
        "Resource" : "arn:aws:s3:::test-oy-global",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "s3:AbortMultipartUpload",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:GetObjectVersion",
          "s3:ListMultipartUploadParts",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        "Resource" : "${aws_s3_bucket.kafka_connect_pulgin.arn}/*",
        "Effect" : "Allow"
      }
    ]
  })
}
