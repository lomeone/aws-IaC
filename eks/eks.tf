resource "aws_eks_cluster" "main" {
  name     = var.name.eks
  role_arn = aws_iam_role.eks-role.arn
  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController
  ]
}

data "tls_certificate" "eks-tls" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}
