data "kubectl_path_documents" "manifests" {
    pattern = "../argocd-apps/*.yaml"
}

resource "kubectl_manifest" "argocd_app_installer" {
    for_each  = toset(data.kubectl_path_documents.manifests.documents)
    yaml_body = each.value

    depends_on = [
    helm_release.argocd,
    kubernetes_labels.istio_enabled
  ]
}