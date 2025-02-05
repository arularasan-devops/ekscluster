variable "cluster_name" {}
variable "env" {}
variable "region" {}
variable "foundationlayer_namespace" {
  type = list(object({
    namespace_name = string
  }))
}
variable "app_namespace" {
  type = list(object({
    namespace_name = string
  }))
}

variable "version_argocd" {}

