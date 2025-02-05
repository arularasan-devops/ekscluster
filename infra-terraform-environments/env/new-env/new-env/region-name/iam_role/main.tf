variable "region" {}
variable "env" {}
variable "s3_metadata_bucket_name" {}
variable "s3_debug_bucket_name" {}



provider "aws" {
  region = var.region
}

module "iamrole" {
  source = "git::https://github.com/celigo/infra-terraform.git//modules/iam_roles"
  env    = var.env
  region = var.region
  s3_metadata_bucket_name = var.s3_metadata_bucket_name
  s3_debug_bucket_name = var.s3_debug_bucket_name
}

