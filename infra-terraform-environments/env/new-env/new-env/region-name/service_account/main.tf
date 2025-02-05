variable "cluster_name" {}
variable "env" {}
variable "region" {}

module "service_account" {

  source       = "git::https://github.com/celigo/infra-terraform.git//modules/service_account"
  cluster_name = var.cluster_name
  env          = var.env
  region       = var.region

}
