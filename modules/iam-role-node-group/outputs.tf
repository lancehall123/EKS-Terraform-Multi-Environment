output "iam_role_arn" {
  description = "The ARN of the node group IAM role"
  value       = aws_iam_role.node_group_role.arn
}
