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

    # EKS Worker Instance Type
    worker_instance_type = string

    # Disk size in GB to be used for each instance
    worker_volume_size = string

    # Desired amount of instances for the auto-scaling of EKS Worker
    worker_asg_desired = string

    # Minimum amount of instances for the auto-scaling of EKS Worker
    worker_asg_min = string

    # Maximum amount of instances for the auto-scaling of EKS Worker
    worker_asg_max = string


  })
}
