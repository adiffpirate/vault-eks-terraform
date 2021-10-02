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

    # VPC ID
    vpc_id = string

    # VPC CIDR block
    vpc_cidr = string

    # IDs for the private subnets on the VPC
    vpc_private_subnets_ids = list(any)

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
