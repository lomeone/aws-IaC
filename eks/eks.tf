


resource "aws_eks_cluster" "main" {
  vpc_config {
    subnet_ids = aws_subnet.eks_control_plane[*].id
  }

  role_arn = aws
}

