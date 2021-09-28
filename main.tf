terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.ca_certificate)
  token                  = module.eks_cluster.service_account_token
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "network" {
  source = "./modules/network"

  project = var.project

  network_azs = data.aws_availability_zones.available.names
  network_vpc_name = var.network_vpc_name
  network_vpc_cidr = var.network_vpc_cidr
  network_vpc_private_subnets_cidr = var.network_vpc_private_subnets_cidr
  network_vpc_public_subnets_cidr = var.network_vpc_public_subnets_cidr

  eks_cluster_name = var.eks_cluster_name
}

module "eks_cluster" {
  source = "./modules/eks_cluster"

  project = var.project

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
