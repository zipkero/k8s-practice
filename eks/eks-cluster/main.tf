variable "aws_region" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "kubernetes-version" {
    type = string
}

variable "cluster-name" {
    type = string
}

variable "eks-practice-cluster-iam-role-arn" {
    type = string
}

variable "eks-practice-cluster-sg-id" {
    type = string
}

resource "aws_eks_cluster" "eks-practice-cluster" {
    name = var.cluster-name
    role_arn = var.eks-practice-cluster-iam-role-arn
    version = var.kubernetes-version

    enabled_cluster_log_types = [
        "api",
        "audit",
        "authenticator",
        "controllerManager",
        "scheduler",
    ]

    vpc_config {
        security_group_ids = [var.eks-practice-cluster-sg-id]
        subnet_ids = var.subnet_ids
        endpoint_public_access = true
    }
}

output "eks-practice-cluster-name" {
    value = aws_eks_cluster.eks-practice-cluster.name
}
