data "kubectl_path_documents" "istio_manifests" {
    pattern = "../argocd-apps/istio/*.yaml"
}

resource "kubectl_manifest" "argocd_istio_installer" {
    for_each  = toset(data.kubectl_path_documents.istio_manifests.documents)
    yaml_body = each.value

    depends_on = [
    helm_release.argocd,
    kubernetes_labels.istio_enabled
  ]
}

data "kubectl_path_documents" "manifests" {
    pattern = "../argocd-apps/*.yaml"
}

resource "kubectl_manifest" "argocd_app_installer" {
    for_each  = toset(data.kubectl_path_documents.manifests.documents)
    yaml_body = each.value

    depends_on = [
    # helm_release.argocd,
    kubectl_manifest.argocd_istio_installer,
    kubernetes_labels.istio_enabled_openim,
    kubernetes_labels.istio_enabled_openim_dependencies,
    kubernetes_labels.istio_enabled_openim_management
  ]
}