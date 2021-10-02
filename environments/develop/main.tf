terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.context.region
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.ca_certificate)
  token                  = module.eks_cluster.service_account_token
}

module "network" {
  source = "../../modules/network"

  context = var.context
  network = var.network

  eks_cluster_name = var.eks_cluster_name
}

module "eks_cluster" {
  source = "../../modules/eks_cluster"

  context = var.context
  network = module.network

  eks_cluster_name = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  eks_worker_instance_type = var.eks_worker_instance_type
  eks_worker_volume_size = var.eks_worker_volume_size
  eks_worker_asg_desired = var.eks_worker_asg_desired
  eks_worker_asg_min = var.eks_worker_asg_min
  eks_worker_asg_max = var.eks_worker_asg_max
}
