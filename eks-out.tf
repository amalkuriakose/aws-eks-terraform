output "eks_cluster_role" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role" {
  value = aws_iam_role.eks_node_role.arn
}

output "eks_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.cluster_id
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_node_group_id" {
  value = aws_eks_node_group.eks_node_group.id
}

output "kubeconfig_cmd" {
  value = "aws eks update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name} --region ${var.aws_region}"
}