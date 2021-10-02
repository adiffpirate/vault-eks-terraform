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

  cluster_name    = var.eks_cluster.name
  cluster_version = var.eks_cluster.version

  vpc_id  = var.network.vpc_id
  subnets = var.network.vpc_private_subnets_ids

  worker_groups = [
    {
      name                          = "${var.eks_cluster.name}-worker-1"
      instance_type                 = var.eks_cluster.worker_instance_type
      asg_desired_capacity          = var.eks_cluster.worker_asg_desired
      asg_min_size                  = var.eks_cluster.worker_asg_min
      asg_max_size                  = var.eks_cluster.worker_asg_max
      root_volume_size              = var.eks_cluster.worker_volume_size
      additional_security_group_ids = [aws_security_group.ssh_eks_cluster.id]
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
