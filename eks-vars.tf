variable "eks_cluster_role_name" {
  type    = string
  default = "eks-cluster-role"
}

variable "eks_node_role_name" {
  type    = string
  default = "eks-node-role"
}

variable "eks_cluster_name" {
  type    = string
  default = "eks-cluster"
}

variable "eks_ng_name" {
  type    = string
  default = "eks-ng-01"
}

variable "key_pair_name" {
  type    = string
  default = "my-key-pair"
}