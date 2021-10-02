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
  host                   = module.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.sensitive.ca_certificate)
  token                  = module.eks_cluster.sensitive.service_account_token
}

module "network" {
  source = "../../modules/network"

  context     = var.context
  network     = var.network
  eks_cluster = var.eks_cluster
}

module "eks_cluster" {
  source = "../../modules/eks_cluster"

  context     = var.context
  network     = module.network
  eks_cluster = var.eks_cluster
}
