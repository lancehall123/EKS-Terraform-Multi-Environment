variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}
variable "node_group_name" {
  type = string
  description = "Node group name"
  default = "practice-node-group"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "practice-eks"
}

variable "env" {
  type        = string
  description = "The environment name (dev, stage, prod)"
  default     = "dev"
}

locals {
  environment_settings = {
    dev = {
      desired_capacity = 1
      max_size         = 2
      min_size         = 1
      instance_types   = ["t3.medium"]
      node_group_name  = "practice-node-group"
    }
    prod = {
      desired_capacity = 3
      max_size         = 6
      min_size         = 2
      instance_types   = ["t3.large"]
      node_group_name  = "prod-node-group"
    }
  }

  settings = local.environment_settings[var.env]
}
