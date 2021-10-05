context = {
  project = "luiz-monteiro-vaultdemo"
  environment = "development"
  region = "eu-west-1"
}

network = {
  vpc_name = "luiz-monteiro-vaultdemo-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  vpc_public_subnets_cidr = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  one_nat_gateway_per_az = false # Create a single NAT gateway for all subnets instead
}

eks_cluster = {
  name = "luiz-monteiro-vaultdemo-eks-cluster"
  version = "1.21" # Must only provide the major and minor versions since AWS handles the patch

  workers = {
    count = 1
    instance_type = "t2.medium"
    volume_size = 5

    asg = { # Nodes
      desired = 4
      min = 3
      max = 5
    }
  }
}

consul = {
  release_name = "consul"
  namespace = "vault"

  helm_chart = {
    version = "0.33.0"
    values_filepath = "./helm-values.yaml"

    override = {
      "server.replicas" = "3" # Must be less or equal to the number of nodes (eks_cluster.workers.asg.desired)
    }
  }
}

vault = {
  release_name = "vault"
  namespace = "vault"

  helm_chart = {
    version = "0.15.0"
    values_filepath = "./helm-values.yaml"

    override = {
      "server.ha.replicas" = "3" # Must be less or equal to the number of nodes (eks_cluster.workers.asg.desired)
    }
  }
}
