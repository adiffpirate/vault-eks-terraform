terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

locals {
  context = var.context
}

provider "aws" {
  region = local.context.region
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.ca_certificate)
  token                  = module.eks_cluster.service_account_token
}

module "network" {
  source = "../../modules/network"

  context = local.context

  network_vpc_name = var.network_vpc_name
  network_vpc_cidr = var.network_vpc_cidr
  network_vpc_private_subnets_cidr = var.network_vpc_private_subnets_cidr
  network_vpc_public_subnets_cidr = var.network_vpc_public_subnets_cidr
  network_one_nat_gateway_per_az = var.network_one_nat_gateway_per_az

  eks_cluster_name = var.eks_cluster_name
}

module "eks_cluster" {
  source = "../../modules/eks_cluster"

  context = local.context

  eks_cluster_name = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  eks_worker_instance_type = var.eks_worker_instance_type
  eks_worker_volume_size = var.eks_worker_volume_size
  eks_worker_asg_desired = var.eks_worker_asg_desired
  eks_worker_asg_min = var.eks_worker_asg_min
  eks_worker_asg_max = var.eks_worker_asg_max

  network_vpc_cidr = var.network_vpc_cidr
  network_vpc_id = module.network.vpc_id
  network_vpc_private_subnets_ids = module.network.vpc_private_subnets_ids
}
