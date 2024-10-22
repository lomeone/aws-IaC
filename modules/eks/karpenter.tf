provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.main.token
  }
}

# resource "aws_ec2_tag" "tag_existing_subnets" {
#   for_each = toset(var.subnet_ids.node)

#   resource_id = each.key

#   key   = "karpenter.sh/discovery"
#   value = aws_eks_cluster.main.name
# }

# resource "helm_release" "karpenter" {
#   create_namespace = true
#   namespace        = "kube-system"
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

# resource "kubernetes_manifest" "karpenter_nodepool" {
#   manifest = {
#     apiVersion = "karpenter.sh/v1"
#     kind       = "NodePool"
#     metadata = {
#       name = "default"
#     }
#     spec = {
#       template = {
#         spec = {
#           nodeClassRef = {
#             group = "karpenter.k8s.aws"
#             kind  = "EC2NodeClass"
#             name  = "default"
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_manifest" "karpenter_node_class" {
#   manifest = {
#     apiVersion = "karpenter.k8s.aws/v1"
#     kind       = "EC2NodeClass"
#     metadata = {
#       name = "default"
#     }
#     spec = {
#       subnetSelectorTerms = {
#         tags = {
#           "karpenter.sh/discovery" = "${aws_eks_cluster.main.name}"
#         }
#       }
#       role = "${aws_iam_role.karpenter}"
#       amiFamily : "AL2023"
#     }
#   }
# }
