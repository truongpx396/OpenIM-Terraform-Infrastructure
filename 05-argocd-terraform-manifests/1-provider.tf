# Datasource: EKS Cluster Auth 
data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

provider "kubernetes" {
  host = data.terraform_remote_state.eks.outputs.cluster_endpoint 
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token = data.aws_eks_cluster_auth.cluster.token
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# resource "kubernetes_namespace" "openim" {
#   metadata {
#     name = "openim"
#   }
# }

# resource "kubernetes_namespace" "openim_dependencies" {
#   metadata {
#     name = "openim-dependencies"
#   }
# }

# resource "kubernetes_namespace" "openim_management" {
#   metadata {
#     name = "openim-management"
#   }
# }

# resource "kubernetes_labels" "istio_enabled" {
#   api_version = "v1"
#   kind        = "Namespace"
#   metadata {
#     name = "default"
#     namespace = "default"
#   }
#   labels = {
#     istio-injection = "enabled"
#   }
# }

# resource "kubernetes_labels" "istio_enabled_openim" {
#   api_version = "v1"
#   kind        = "Namespace"
#   metadata {
#     name = "openim"
#     namespace = "openim"
#   }
#   labels = {
#     istio-injection = "enabled"
#   }

#   depends_on = [
#     # kubernetes_namespace.openim,
#     helm_release.argocd
#   ]
# }

# resource "kubernetes_labels" "istio_enabled_openim_dependencies" {
#   api_version = "v1"
#   kind        = "Namespace"
#   metadata {
#     name = "openim-dependencies"
#     namespace = "openim-dependencies"
#   }
#   labels = {
#     istio-injection = "enabled"
#   }

#   depends_on = [
#     # kubernetes_namespace.openim_dependencies,
#     helm_release.argocd
#   ]
# }

# resource "kubernetes_labels" "istio_enabled_openim_management" {
#   api_version = "v1"
#   kind        = "Namespace"
#   metadata {
#     name = "openim-management"
#     namespace = "openim-management"
#   }
#   labels = {
#     istio-injection = "enabled"
#   }

#   depends_on = [
#     # kubernetes_namespace.openim_management
#     helm_release.argocd
#   ]
# }



# resource "kubernetes_namespace" "istio-ingress" {
#   metadata {
#     labels = {
#       istio-injection = "enabled"
#     }

#     name = "istio-ingress"
#   }
# }


provider "kubectl" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

# HELM Provider
provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}