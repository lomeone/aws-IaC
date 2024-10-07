resource "aws_eks_cluster" "main" {
  name     = var.name.eks
  role_arn = aws_iam_role.eks.arn
  vpc_config {
    subnet_ids = var.subnet_ids.control_plane
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController
  ]
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}

data "tls_certificate" "eks_tls" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}
