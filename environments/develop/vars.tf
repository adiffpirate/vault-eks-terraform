variable "context" {
  type = object({
    # Project Name
    project = string

    # Region
    region = string

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

    # EKS Cluster Version (must only provide the major and minor versions since AWS handles the patch)
    version = string

    # Workers configuration
    workers = object({
      # Amount of workers to deploy
      count = string
      # Instance Type
      instance_type = string
      # Disk size in GB to be used for each instance
      volume_size = string

      # EC2 Auto Scaling Group configuration
      asg = object({
        # Desired amount of instances
        desired = string
        # Minimum amount of instances
        min = string
        # Maximum amount of instances
        max = string
      })

    })

  })
}
