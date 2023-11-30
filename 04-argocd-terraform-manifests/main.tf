resource "helm_release" "argocd" {
  name = var.helm_release

  repository          = var.helm_repository
  repository_username = var.helm_repository_username
  repository_password = var.helm_repository_password

  chart     = "argo-cd"
  version   = var.chart_version
  namespace = var.helm_namespace
  timeout   = 1200

  values = [
    var.values,
  ]

  depends_on = [
    kubernetes_namespace.argocd,
  ]
}
