# data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}:sub"
#       values   = ["system:serviceaccount:kube-system:aws-node"]
#     }

#     principals {
#       identifiers = [aws_iam_openid_connect_provider.example.arn]
#       type        = "Federated"
#     }
#   }
# }

# resource "aws_iam_role" "eks_oidc" {
#   assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
#   name               = "example"
# }
