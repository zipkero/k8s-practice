resource "aws_security_group" "eks-practice-cluster-sg" {
    name = "eks-practice-cluster-sg"
    vpc_id = var.vpc-id
    tags = {
      Name = "eks-practice-cluster-sg"
    }
}

resource "aws_security_group_rule" "eks-cluster-sg-ssh-inbound" {
    security_group_id = aws_security_group.eks-practice-cluster-sg.id
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks-cluster-sg-ssh-outbound" {
    security_group_id = aws_security_group.eks-practice-cluster-sg.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}