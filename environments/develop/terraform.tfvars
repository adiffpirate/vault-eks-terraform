context = {
  project = "luiz-monteiro-vault"
  environment = "development"
  region = "eu-west-1"
}

network = {
  vpc_name = "luiz-monteiro-vault-vpc-dev"
  vpc_cidr = "10.0.0.0/16"
  vpc_private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  vpc_public_subnets_cidr = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  one_nat_gateway_per_az = false
}

eks_cluster = {
  name = "luiz-monteiro-vault-eks-cluster-dev"
  version = "1.21" # Must only provide the major and minor versions since AWS handles the patch
  worker_instance_type = "t2.small"
  worker_volume_size = 5
  worker_asg_desired = 3
  worker_asg_min = 2
  worker_asg_max = 5
}
