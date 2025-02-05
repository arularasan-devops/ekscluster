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


module "foundationlayer" {
  source                               = "git::https://github.com/celigo/infra-terraform.git//modules/foundation_layers-gitops"
  cluster_name                         = var.cluster_name
  env                                  = var.env
  region                               = var.region
  version_argocd                       = var.version_argocd
  app_namespace                        = var.app_namespace
  foundationlayer_namespace            = var.foundationlayer_namespace

}