resource "aws_eks_node_group" "eks-practice-nodegroup" {
    cluster_name = var.cluster-name
    node_group_name = "eks-practice-nodegroup"
    node_role_arn = aws_iam_role.eks-practice-nodegroup-iam-role.arn
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

    depends_on = [ 
        aws_iam_role_policy_attachment.eks-practice-nodegroup-worker-iam-policy,
        aws_iam_role_policy_attachment.eks-practice-nodegroup-cni-iam-policy,
        aws_iam_role_policy_attachment.eks-practice-nodegroup-ec2-iam-policy
    ]

    tags = {
        "Name" = "${aws_eks_cluster.eks-practice-cluster.name}-worker-node"
    }
}