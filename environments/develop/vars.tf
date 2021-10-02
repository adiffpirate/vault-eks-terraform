variable "project" {
  type        = string
  description = "Project Name"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "environment" {
  type        = string
  description = "Environment"
}



# Network

variable "network_vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "network_vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "network_vpc_private_subnets_cidr" {
  type        = list
  description = "CIDR block for the private subnets"
}

variable "network_vpc_public_subnets_cidr" {
  type        = list
  description = "CIDR block for the public subnets"
}

variable "network_one_nat_gateway_per_az" {
  type        = bool
  description = "Create a NAT Gateway in each Availability Zone"
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
