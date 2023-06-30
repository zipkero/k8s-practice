variable "aws_region" {
    default = "ap-northeast-2"
}

variable "vpc-id" {
    default = "vpc-082b1fe2182abf05c"
}

variable "cluster-name" {
    default = "eks-practice-cluster"
}

variable "kubernetes-version" {
    default = "1.27"
}

variable "subnet_ids" {
    type = list(string)
    default = [ "subnet-0ae550f2135eb08d8", "subnet-0ace560107842f6c3" ]
}