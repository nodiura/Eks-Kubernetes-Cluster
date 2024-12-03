output "cluster_name" {
  value = aws_eks_cluster.my_cluster.name
}
output "cluster_endpoint" {
  value = aws_eks_cluster.my_cluster.endpoint
}
output "cluster_security_group_ids" {
  value = aws_security_group.eks_security_group.id
}