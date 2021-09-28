terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"

  name = var.network_vpc_name
  cidr = var.network_vpc_cidr

  azs = var.network_azs
  private_subnets = var.network_vpc_private_subnets_cidr
  public_subnets = var.network_vpc_public_subnets_cidr

  enable_nat_gateway = true
  one_nat_gateway_per_az = true
  single_nat_gateway = false

  tags = {
    project = var.project
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }

  private_subnet_tags = {
    project = var.project
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
  }

  public_subnet_tags = {
    project = var.project
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }
}
