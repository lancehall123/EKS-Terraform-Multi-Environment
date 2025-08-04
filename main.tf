provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  name   = var.cluster_name
  cidr   = "10.0.0.0/16"
}

module "iam_role_cluster" {
  source    = "./modules/iam-role-cluster"
  role_name = "EKSClusterRole"
  tags = {
    Name        = "eks-cluster-role"
    Environment = "dev"
  }
}

module "eks_cluster" {
  source           = "./modules/eks_cluster"
  region           = var.region
  cluster_name     = var.cluster_name
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.public_subnets
  cluster_role_arn = module.iam_role_cluster.iam_role_arn
}

module "iam_role_node_group" {
  source    = "./modules/iam-role-node-group"
  role_name = "EKSNodeGroupRole"
  tags = {
    Name        = "eks-node-group-role"
    Environment = var.env
  }
}

module "eks_node_group" {
  source           = "./modules/eks_node_group"
  cluster_name     = var.cluster_name
  subnet_ids       = module.vpc.public_subnets
  node_group_name  = var.node_group_name
  instance_types   = var.instance_types
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
  node_role_arn    = module.iam_role_node_group.iam_role_arn
}
module "remote_state" {
  source      = "./modules/remote_state"
  bucket_name = "terraform-eks-state-lance"
  tags = {
    Name        = "terraform-state"
    Environment = var.env
  }
}
