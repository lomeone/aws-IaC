
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

  # statement {
  #   actions = [
  #     "kafka:ListNodes",
  #     "kafka:DescribeCluster"
  #   ]

  #   effect = "Allow"

  #   resources = ["arn:aws:kafka:ap-northeast-2:058264332540:cluster/hansu-msk/*"]
  # }

  # statement {
  #   actions = [
  #     "kafka-cluster:Connect",
  #     "kafka-cluster:AlterCluster",
  #     "kafka-cluster:DescribeCluster"
  #   ]

  #   effect = "Allow"

  #   resources = ["arn:aws:kafka:ap-northeast-2:058264332540:cluster/hansu-msk/*"]
  # }

  # statement {
  #   actions = [
  #     "kafka-cluster:*Topic*",
  #     "kafka-cluster:ReadData",
  #     "kafka-cluster:WriteData"
  #   ]

  #   effect = "Allow"

  #   resources = ["arn:aws:kafka:ap-northeast-2:058264332540:topic/hansu-msk/*"]
  # }

  # statement {
  #   actions = [
  #     "kafka-cluster:AlterGroup",
  #     "kafka-cluster:DescribeGroup"
  #   ]

  #   effect = "Allow"

  #   resources = ["arn:aws:kafka:ap-northeast-2:058264332540:group/hansu-msk/*"]
  # }

  statement {
    actions = ["kafka:*"]

    effect = "Allow"

    resources = [
      "arn:aws:kafka:ap-northeast-2:058264332540:cluster/hansu-msk/*",
    ]
  }

  statement {
    actions = ["kafka-cluster:*"]

    effect = "Allow"

    resources = [
      "arn:aws:kafka:ap-northeast-2:058264332540:cluster/hansu-msk/*",
      "arn:aws:kafka:ap-northeast-2:058264332540:group/hansu-msk/*",
      "arn:aws:kafka:ap-northeast-2:058264332540:topic/hansu-msk/*",
      "arn:aws:kafka:ap-northeast-2:058264332540:transactional-id/hansu-msk/*"
    ]
  }
}
