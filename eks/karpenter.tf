provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.main.token
  }
}

# resource "helm_release" "karpenter" {
#   provider         = helm.cluster
#   create_namespace = true
#   namepsace        = "kube-system"
#   name             = "karpenter"
#   repository       = "oci://public.ecr.aws/karpenter"
#   chart            = "karpenter"

#   depends_on = [aws_iam_role.karpenter]

#   values = [<<EOF
#     serviceAccount:
#       create: true
#       name: karpenter
#       annotations:
#         eks.amazonaws.com/role-arn: ${aws_iam_role.karpenter.arn}
#     settings:
#       clusterName: "${aws_eks_cluster.main.name}"
#       clusterEndpoint: "${aws_eks_cluster.main.endpoint}"
#     controller:
#       resources:
#         requests:
#           cpu: 1
#           memory: 1Gi
#         limits:
#           memory: 1Gi

#     EOF
#   ]
# }

# resource "kubernetes_manifest" "karpenter_provisioner" {
#   manifest = {
#     apiVersion = "karpenter.k8s.aws/v1"
#     kind       = "Provisioner"
#     metadata = {
#       name = "default"
#     }
#     spec = {
#       limits = {
#         resources = {
#           cpu    = "1000"
#           memory = "1000Gi"
#         }
#       }
#       requirements = [
#         {
#           key      = "node.kubernetes.io/instance-type"
#           operator = "In"
#           values   = ["t4g.large", "m7g.large", "m7g.xlarge"]
#         }
#       ]
#     }
#   }
# }
