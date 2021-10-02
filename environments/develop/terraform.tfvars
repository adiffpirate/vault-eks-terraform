context = {
  project = "luiz-monteiro-vault"
  environment = "development"
  region = "eu-west-1"
}

# Network
network_vpc_name = "luiz-monteiro-vault-vpc-dev"
network_vpc_cidr = "10.0.0.0/16"
network_vpc_private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
network_vpc_public_subnets_cidr = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
network_one_nat_gateway_per_az = false

# EKS
eks_cluster_name = "luiz-monteiro-vault-eks-cluster-dev"
eks_cluster_version = "1.21" # Must only provide the major and minor versions since AWS handles the patch
eks_worker_instance_type = "t2.small"
eks_worker_volume_size = 5
eks_worker_asg_desired = 3
eks_worker_asg_min = 2
eks_worker_asg_max = 5
