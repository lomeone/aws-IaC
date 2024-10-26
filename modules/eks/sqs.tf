resource "aws_sqs_queue" "karpenter_spot" {
  name = "Karpenter-${aws_eks_cluster.main.name}-SpotInterruptionQueue"

  message_retention_seconds = 300
  sqs_managed_sse_enabled   = true
}
