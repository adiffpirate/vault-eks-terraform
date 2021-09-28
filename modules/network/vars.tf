variable "project" {
  type        = string
  description = "Project Name"
}

# Network

variable "network_azs" {
  type        = list
  description = "AWS Availability Zones"
}

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

# EKS

variable "eks_cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}
