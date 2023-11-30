
# import {
#   to = aws_eks_addon.vpc_cni
#   id = "aws_eks_cluster.eks_cluster.name:aws_eks_addon.vpc_cni.name"
# }
resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.eks_cluster.id
  addon_name   = "vpc-cni"
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

#   resolve_conflicts = "OVERWRITE"

  configuration_values = jsonencode({
     env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
  })
}