remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {

    bucket = "integrator-<new-env>-terragrunt-terraform-eks-state-<region-name>" # Bucket Name to Store State file

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "<region-name>" # Bucket Region
    encrypt        = true
    
  }
}

inputs = {
  region                               = "<region-name>"           # Region
  env                                  = "<new-env>"           # Environment  
  #Subnet Creation
  name_prefix                          = "<new-env>-aws-eks-<region-name>"           # Subnet Prefix
  newbits                              = "24"         # CIDR
  subnets_count                        = "2"          # Public Subnet
  private_subnets_count                = "2"          # Private Subnet 
  cluster_name                         = "<new-env>-aws-eks-<region-name>"           # update ClusterName

  # S3 Bucket Creation 
  s3_metadata_bucket_name              = "<s3_metadata_bucket_name>" # metadata s3 bucket name
  s3_debug_bucket_name                 = "<s3_debug_bucket_name>" # debug s3 bucket name

  
  #Worker Node
  keyname                              = "<key-pair-name>"     # create ssh key name and update
  min_instance_count                   = "1"
  max_instance_count                   = "4"
  desired_instance_count               = "1"
  ami                                  = "amazon-eks-node-1.23-v*"
  instance_type                        = "t3.xlarge"
  
  #Cluster
  k8s_version                          = "1.23"        
  public_cluster                       = "<isPublicCluster>"     # to enable cluster public access change value to "true" otherwise "false"

  
  #Helm Version
  version_argocd                       = "5.5.3"
  
  #Namespace Creation 
  foundationlayer_namespace   = [ { "namespace_name" : "argocd" },{ "namespace_name" : "istio-system" },{ "namespace_name" : "istio-gateway" }]
  
  #Application Namespace which need to add istio injection
  app_namespace               = [ {"namespace_name" : "core" },{ "namespace_name" : "io" },
                                { "namespace_name" : "ia" },{ "namespace_name" : "istio-ingress" },{ "namespace_name" : "ui" }, { "namespace_name" : "testing" }]
 
  #Private Hosted Zone

  domain = "celigo.io" #add domain name
  records= ["*.celigo.io","*.ia.celigo.io"] #add cname records

}



