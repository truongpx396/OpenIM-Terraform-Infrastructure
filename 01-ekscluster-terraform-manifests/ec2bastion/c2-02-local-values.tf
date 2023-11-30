# Define Local Values in Terraform
locals {
  
  name = ""
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    # owners = local.owners
    # environment = local.environment
  }
  # eks_cluster_name = "${local.name}-${var.cluster_name}"
  # eks_vpc_name=  "${local.eks_cluster_name}-${var.vpc_name}"
} 