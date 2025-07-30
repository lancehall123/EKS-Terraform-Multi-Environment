variable "cluster_name" {}
variable "cluster_role_arn" {}
variable "subnet_ids" {
  type = list(string)
}
variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

