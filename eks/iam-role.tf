resource "aws_iam_role" "eks-practice-cluster-iam-role" {
    name = "eks-practice-cluster-iam-role"
    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-practice-cluster-iam-policy" {
    role = aws_iam_role.eks-practice-cluster-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks-practice-vpc-iam-policy" {
    role = aws_iam_role.eks-practice-cluster-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role" "eks-practice-nodegroup-iam-role" {
    name = "eks-practice-nodegroup"
    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
POLICY  
}

resource "aws_iam_role_policy_attachment" "eks-practice-nodegroup-worker-iam-policy" {
    role = aws_iam_role.eks-practice-nodegroup-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-practice-nodegroup-cni-iam-policy" {
    role = aws_iam_role.eks-practice-nodegroup-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks-practice-nodegroup-ec2-iam-policy" {
    role = aws_iam_role.eks-practice-nodegroup-iam-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}