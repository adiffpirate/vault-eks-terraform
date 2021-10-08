terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.20.0"

  cluster_name     = var.eks_cluster.name
  cluster_version  = var.eks_cluster.version
  write_kubeconfig = false

  vpc_id  = var.network.vpc_id
  subnets = var.network.vpc_private_subnets_ids

  worker_groups = [
    for i in range(var.eks_cluster.workers.count) : {
      name                          = "worker-${i}"
      instance_type                 = var.eks_cluster.workers.instance_type
      asg_desired_capacity          = var.eks_cluster.workers.asg.desired
      asg_min_size                  = var.eks_cluster.workers.asg.min
      asg_max_size                  = var.eks_cluster.workers.asg.max
      root_volume_size              = var.eks_cluster.workers.volume_size
    }
  ]

  tags = {
    Name        = var.eks_cluster.name
    project     = var.context.project
    environment = var.context.environment
  }
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}
