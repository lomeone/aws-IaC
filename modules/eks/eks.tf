resource "aws_eks_cluster" "main" {
  name     = var.name.eks
  role_arn = aws_iam_role.eks.arn
  vpc_config {
    subnet_ids = var.subnet_ids.control_plane
  }

  version = "1.31"

  tags = {
    "karpenter.sh/discovery" = "${var.name.eks}"
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

resource "aws_eks_node_group" "default_node_group" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "default_node_group"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.subnet_ids.node

  scaling_config {
    desired_size = var.node_group.desired_size
    max_size     = var.node_group.max_size
    min_size     = var.node_group.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy
  ]

  ami_type = "AL2023_ARM_64_STANDARD"

  instance_types = var.node_group.node_instance_type
}

resource "null_resource" "add_karpenter_tag" {
  count = length(var.subnet_ids.node)

  provisioner "local-exec" {
    command = <<EOT
      aws ec2 create-tags --resources ${aws_eks_cluster.main.vpc_config[0].cluster_security_group_id} --tags Key=karpenter.sh/discovery,Value=${aws_eks_cluster.main.name}
    EOT
  }
}
