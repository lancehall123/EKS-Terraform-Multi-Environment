variable "region" {}
variable "cluster_name" {}
# variable "vpc_id" {}
# variable "subnet_ids" {
#   type = list(string)
# }
# variable "cluster_role_arn" {}
variable "node_group_name" {}
variable "instance_types" {
  type = list(string)
}
variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}
# # variable "node_role_arn" {
# #   description = "IAM role ARN for the node group"
# #   type        = string
# # }
