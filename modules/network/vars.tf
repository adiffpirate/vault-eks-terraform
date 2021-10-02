variable "context" {
  type = object({

    # Project Name
    project = string

    # Environment
    environment = string

  })
}



variable "network" {
  type = object({

    # VPC Name
    vpc_name = string

    # VPC CIDR block
    vpc_cidr = string

    # CIDR block for the private subnets
    vpc_private_subnets_cidr = list(any)

    # CIDR block for the public subnets
    vpc_public_subnets_cidr = list(any)

    # Create a NAT Gateway in each Availability Zone
    # (If this option is set to false it will create a single NAT Gateway instead)
    one_nat_gateway_per_az = bool

  })
}



variable "eks_cluster" {
  type = object({

    # EKS Cluster Name
    name = string

  })
}
