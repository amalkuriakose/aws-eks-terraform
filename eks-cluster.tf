resource "aws_eks_cluster" "eks_cluster" {
  name     = "${local.project_name}-${var.eks_cluster_name}"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.30"
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  vpc_config {
    subnet_ids         = [for item in aws_subnet.private_subnets : item.id]
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-${var.eks_cluster_name}"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_policy_1,
    aws_iam_role_policy_attachment.eks_cluster_role_policy_2
  ]
}

# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
# }

# resource "local_file" "private_key" {
#   content  = tls_private_key.ssh_key.private_key_pem
#   filename = "${var.key_pair_name}.pem"
# }

# resource "aws_key_pair" "ec2_key_pair" {
#   key_name   = var.key_pair_name
#   public_key = tls_private_key.ssh_key.public_key_openssh
# }

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.project_name}-${var.eks_ng_name}"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [for item in aws_subnet.public_subnets : item.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  capacity_type  = "ON_DEMAND"
  disk_size      = "20"
  instance_types = ["t3.medium"]

  # remote_access {
  #   ec2_ssh_key               = aws_key_pair.ec2_key_pair.key_name
  #   source_security_group_ids = [aws_security_group.eks_node_sg.id]
  # }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-${var.eks_ng_name}"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_role_policy_1,
    aws_iam_role_policy_attachment.eks_node_role_policy_2,
    aws_iam_role_policy_attachment.eks_node_role_policy_3
  ]
}