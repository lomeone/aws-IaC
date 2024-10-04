resource "aws_iam_role" "storagegateway_bucket_access" {
  name = var.name.iam_role
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "storagegateway.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "storagegateway_bucket_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetAccelerateConfiguration",
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [aws_s3_bucket.kafka_connect_plugin.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["${aws_s3_bucket.kafka_connect_plugin.arn}/*"]
  }
}

resource "aws_iam_role_policy" "name" {
  name   = "${var.name.iam_role}_policy"
  role   = aws_iam_role.storagegateway_bucket_access.id
  policy = data.aws_iam_policy_document.storagegateway_bucket_policy.json
}
