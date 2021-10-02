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

  azs = data.aws_availability_zones.available.names
  private_subnets = var.network_vpc_private_subnets_cidr
  public_subnets = var.network_vpc_public_subnets_cidr

  enable_nat_gateway = true
  one_nat_gateway_per_az = var.network_one_nat_gateway_per_az
  single_nat_gateway = var.network_one_nat_gateway_per_az == true ? false : true

  tags = {
    project = var.project
    environment = var.environment
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }

  private_subnet_tags = {
    project = var.project
    environment = var.environment
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
  }

  public_subnet_tags = {
    project = var.project
    environment = var.environment
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
