resource "aws_eks_cluster" "eks-practice-cluster" {
    depends_on = [
        aws_iam_role_policy_attachment.eks-practice-cluster-iam-policy, 
        aws_iam_role_policy_attachment.eks-practice-vpc-iam-policy,
    ] 

    name = var.cluster-name
    role_arn = aws_iam_role.eks-practice-cluster-iam-role.arn
    version = var.kubernetes-version

    enabled_cluster_log_types = [
        "api",
        "audit",
        "authenticator",
        "controllerManager",
        "scheduler",
    ]

    vpc_config {
        security_group_ids = [aws_security_group.eks-practice-cluster-sg.id]
        subnet_ids = var.subnet_ids
        endpoint_public_access = true
    }
}