
variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "hr-dev"
}

variable "common_tags" {
  description = "common tags"
  type        = map(string)
  default     = {}
}

variable "eks_nodegroup_role_arn" {
  description = "nodegroup role arn"
  type        = string
}