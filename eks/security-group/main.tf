variable "vpc_id" {
    type = string
}

resource "aws_security_group" "eks-practice-cluster-sg" {
    name = "eks-practice-cluster-sg"
    vpc_id = var.vpc_id
    tags = {
        Name = "eks-practice-cluster-sg"
    }
}

resource "aws_security_group_rule" "eks-cluster-sg-https-inbound" {
    security_group_id = aws_security_group.eks-practice-cluster-sg.id
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks-cluster-sg-http-inbound" {
    security_group_id = aws_security_group.eks-practice-cluster-sg.id
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
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

output "eks-practice-cluster-sg-id" {
    value = aws_security_group.eks-practice-cluster-sg.id
}

