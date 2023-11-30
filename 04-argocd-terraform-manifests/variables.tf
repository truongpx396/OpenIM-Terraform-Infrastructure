variable "helm_namespace" {
  description = "The namespace Helm will install the chart under"
  default     = "argocd"
}
variable "helm_release" {
  default     = "argo-cd"
  description = "The name of the Helm release"
}

variable "helm_repository" {
  default     = "https://argoproj.github.io/argo-helm"
  description = "The repository where the Helm chart is stored"
}
variable "helm_repository_password" {
  type        = string
  nullable    = false
  default     = ""
  description = "The password of the repository where the Helm chart is stored"
  sensitive   = true
}
variable "helm_repository_username" {
  type        = string
  nullable    = false
  default     = ""
  description = "The username of the repository where the Helm chart is stored"
  sensitive   = true
}
variable "chart_version" {
  description = "Version of the Helm chart"
  default     = "5.46.7"
}

variable "values" {
  default     = ""
  type        = string
  description = "Values to be passed to the Helm chart"
}