variable "cluster-name" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "eks-practice-nodegroup-iam-role-arn" {
    type = string
}

variable "eks-practice-cluster-name" {
    type = string
}

resource "aws_eks_node_group" "eks-practice-nodegroup" {
    cluster_name = var.cluster-name
    node_group_name = "eks-practice-nodegroup"
    node_role_arn = var.eks-practice-nodegroup-iam-role-arn
    subnet_ids = var.subnet_ids
    instance_types = ["t2.micro"]
    disk_size = 20

    labels = {
        "role" = "eks-nodegroup"
    }

    scaling_config {
        desired_size = 2
        min_size = 1
        max_size = 2
    }

    tags = {
        "Name" = "${var.eks-practice-cluster-name}-worker-node"
    }
}