module "providers" {
    source = "./providers"

    aws_region = var.aws_region
}

module "iam" {
    source = "./iam-role"
}

module "vpc" {
    source = "./vpc"

    aws_region = var.aws_region
}

module "security-group" {
    source = "./security-group"

    vpc_id = module.vpc.vpc_id
}

module "eks-cluster" {
    source = "./eks-cluster"

    aws_region = var.aws_region
    subnet_ids = module.vpc.subnet_ids
    cluster-name = var.cluster-name
    kubernetes-version = var.kubernetes-version

    eks-practice-cluster-iam-role-arn = module.iam.eks-practice-cluster-iam-role-arn    
    eks-practice-cluster-sg-id = module.security-group.eks-practice-cluster-sg-id

    depends_on = [ module.iam, module.vpc, module.security-group ]
}

module "eks-nodegroup" {
    source = "./eks-nodegroup"

    cluster-name = var.cluster-name
    eks-practice-cluster-name = module.eks-cluster.eks-practice-cluster-name
    subnet_ids = module.vpc.subnet_ids
    eks-practice-nodegroup-iam-role-arn = module.iam.eks-practice-nodegroup-iam-role-arn

    depends_on = [ module.eks-cluster ]
}


