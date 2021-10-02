variable "context" {
  type = object({
    # Project Name
    project     = string
    # Environment
    environment = string
  })
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
  description = <<EOT
  Create a NAT Gateway in each Availability Zone.
  If this option is set to false it will create a single NAT Gateway instead.
  EOT
}

# EKS

variable "eks_cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}
