variable "context" {
  type = object({
    # Project Name
    project     = string
    # Environment
    environment = string
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



# Network

variable "network_vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "network_vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "network_vpc_private_subnets_ids" {
  type        = list
  description = "IDs for the private subnets on the VPC"
}
