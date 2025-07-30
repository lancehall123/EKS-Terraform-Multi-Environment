output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}
