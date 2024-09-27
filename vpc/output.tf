output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = {
    public_subnets     = aws_subnet.public[*].id
    eks_control_plane  = aws_subnet.eks_control_plane[*].id
    private_subnets    = aws_subnet.private[*].id
    db_private_subnets = aws_subnet.db_private[*].id
  }
}
