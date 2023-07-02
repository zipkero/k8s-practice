variable "aws_region" {
    type = string
}

resource "aws_vpc" "eks-practice-vpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "eks-practice-vpc"
    }
}

resource "aws_subnet" "eks-practice-subnet-public1" {
    vpc_id     = aws_vpc.eks-practice-vpc.id
    cidr_block = "192.168.0.0/20"
    availability_zone = "${var.aws_region}a"
    map_public_ip_on_launch = true
    tags = {
        Name = "eks-practice-subnet-public1"
    }
}

resource "aws_subnet" "eks-practice-subnet-public2" {
    vpc_id     = aws_vpc.eks-practice-vpc.id
    cidr_block = "192.168.32.0/20"
    availability_zone = "${var.aws_region}c"
    map_public_ip_on_launch = true
    tags = {
        Name = "eks-practice-subnet-public2"
    }
}

resource "aws_internet_gateway" "eks-practice-igw" {
    vpc_id = aws_vpc.eks-practice-vpc.id
    tags = {
        Name = "eks-practice-igw"
    }
}

resource "aws_default_route_table" "eks-practice-rtb-public" {
    default_route_table_id = aws_vpc.eks-practice-vpc.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks-practice-igw.id
    }
    tags = {
        Name = "eks-practice-rtb-public"
    }
}

resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.eks-practice-subnet-public1.id
    route_table_id = aws_default_route_table.eks-practice-rtb-public.id
}

resource "aws_route_table_association" "b" {
    subnet_id      = aws_subnet.eks-practice-subnet-public2.id
    route_table_id = aws_default_route_table.eks-practice-rtb-public.id
}

output "vpc_id" {
    value = aws_vpc.eks-practice-vpc.id
}

output "subnet_ids" {
    value = [aws_subnet.eks-practice-subnet-public1.id, aws_subnet.eks-practice-subnet-public2.id]
}