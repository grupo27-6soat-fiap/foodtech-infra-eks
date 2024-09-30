
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}
 
module "eks" {
  source = "./modules/eks"
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.subnet_ids
  security_group_id    = module.vpc.security_group_id
  eks_role_arn         = module.iam.eks_role_arn
  node_group_role_arn  = module.iam.node_group_role_arn
}
