terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.3.0"
    }
  }
}

provider "aws" {
  region = var.context.region
}

provider "kubernetes" {
  host                   = module.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.sensitive.ca_certificate)
  token                  = module.eks_cluster.sensitive.auth_token
}

provider "helm" {
  debug = true
  kubernetes {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.sensitive.ca_certificate)
    token                  = module.eks_cluster.sensitive.auth_token
  }
}
