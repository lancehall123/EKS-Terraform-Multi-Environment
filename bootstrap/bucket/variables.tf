
variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform remote state"
  default     = "terraform-eks-state-lance"
}

variable "dynamodb_table" {
  description = "Name of the DynamoDB table for state locking"
  default     = "terraform-eks-state-lance-locks"
}
