variable "env" {}
variable "region" {}
variable "cluster_name" {}
variable "servicename" {default = "eksworker"}
variable "alertgroup" {default = "devops_team"}
variable "k8s_version" {} 
variable "public_cluster" {}


data "aws_iam_role" "ControlPlaneRole" {
  name = "${var.env}_EKSControlPlaneRole"
}

provider "aws" {
  region = "${var.region}"
}

module "eks_controlplane_generic" {
  source                = "git::https://github.com/celigo/infra-terraform.git//modules/eks_controlplane_generic/"
  name_prefix           = var.cluster_name
  k8s_version           = var.k8s_version
  private_endpoint      = true
  public_endpoint       = var.public_cluster
  servicename           = "eksworker"
  worker_subnets        = ["${data.aws_subnet_ids.worker.ids}"]
  env                   = var.env
  controlplane_iam_role = data.aws_iam_role.ControlPlaneRole.name
  alertgroup = var.alertgroup
  vpc_id = "${data.aws_vpc.defaultvpc.id}"
}
