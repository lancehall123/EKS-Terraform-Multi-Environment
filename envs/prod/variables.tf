variable "region" {}
variable "cluster_name" {}
variable "node_group_name" {}
variable "instance_types" {
  type = list(string)
}
variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}
variable "env" {}

