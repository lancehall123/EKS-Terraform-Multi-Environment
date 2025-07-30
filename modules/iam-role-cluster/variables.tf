# modules/iam-role-cluster/variables.tf

variable "role_name" {
  description = "The name of the IAM role for the EKS cluster"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the IAM role"
  type        = map(string)
  default     = {}
}

