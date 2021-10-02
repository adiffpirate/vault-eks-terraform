variable "context" {
  type = object({
    # Project Name
    project     = string
    # Region
    region      = string
    # Environment
    environment = string
  })
}

variable "network" {
  type = object({
    # VPC Name
    vpc_name                 = string
    # VPC CIDR block
    vpc_cidr                 = string
    # CIDR block for the private subnets
    vpc_private_subnets_cidr = list(any)
    # CIDR block for the public subnets
    vpc_public_subnets_cidr  = list(any)
    # Create a NAT Gateway in each Availability Zone
    # (If this option is set to false it will create a single NAT Gateway instead)
    one_nat_gateway_per_az   = bool
  })
}



# EKS

variable "eks_cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}

variable "eks_cluster_version" {
  type        = string
  description = "EKS Cluster Version (must only provide the major and minor versions since AWS handles the patch)"
}

variable "eks_worker_instance_type" {
  type        = string
  description = "EKS Worker Instance Type"
}

variable "eks_worker_volume_size" {
  type        = string
  description = "Disk size in GB to be used for each instance"
}

variable "eks_worker_asg_desired" {
  type        = string
  description = "Desired amount of instances for the auto-scaling of EKS Worker"
}

variable "eks_worker_asg_min" {
  type        = string
  description = "Minimum amount of instances for the auto-scaling of EKS Worker"
}

variable "eks_worker_asg_max" {
  type        = string
  description = "Maximum amount of instances for the auto-scaling of EKS Worker"
}
