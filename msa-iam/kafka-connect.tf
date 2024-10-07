
resource "aws_iam_role" "kafka_connect" {
  name               = "KafkaConnectRole-${var.eks.name}"
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_kafka_connect_assume_role.json
}

data "aws_iam_policy_document" "eks_oidc_kafka_connect_assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks.oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kafka-system:kafka-connect"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks.oidc_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [var.eks.oidc_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role_policy_attachment" "kafka_connect_KafkaClusterAllowPolicy" {
  role       = aws_iam_role.kafka_connect.name
  policy_arn = aws_iam_policy.kafka_cluster_allow.arn
}

resource "aws_iam_policy" "kafka_cluster_allow" {
  name   = "KafkaClusterAllowPolicy"
  policy = data.aws_iam_policy_document.kafka_cluster_allow_policy.json
}

data "aws_iam_policy_document" "kafka_cluster_allow_policy" {
  version = "2012-10-17"

  statement {
    actions = [
      "kafka-cluster:AlterTopicDynamicConfiguration",
      "kafka-cluster:CreateTopic",
      "kafka-cluster:ReadData",
      "kafka-cluster:Connect",
      "kafka-cluster:WriteData"
    ]

    effect = "Allow"

    resources = ["arn:aws:kafka:ap-northeast-2:058264332540:cluster/hansu-msk/8f1dc94f-4256-4d7d-b211-2bf292b0e4cd-2"]
  }
}
