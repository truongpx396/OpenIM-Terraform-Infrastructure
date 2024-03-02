# Datasource: 
data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.cluster.token
}

resource "kubernetes_namespace" "openim" {
  metadata {
    name = "openim"
  }
}

resource "kubernetes_namespace" "openim_dependencies" {
  metadata {
    name = "openim-dependencies"
  }
}

resource "kubernetes_namespace" "openim_management" {
  metadata {
    name = "openim-management"
  }
}