output "vpc_name" {
  description = "VPC Name"
  value       = var.network.vpc_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = var.network.vpc_cidr
}

output "vpc_private_subnets_cidr" {
  description = "CIDR block for the private subnets"
  value       = var.network.vpc_private_subnets_cidr
}

output "vpc_private_subnets_ids" {
  description = "IDs for the private subnets on the VPC"
  value       = module.vpc.private_subnets
}

output "vpc_public_subnets_cidr" {
  description = "CIDR block for the public subnets"
  value       = var.network.vpc_public_subnets_cidr
}
output "vpc_public_subnets_ids" {
  description = "IDs for the public subnets on the VPC"
  value       = module.vpc.public_subnets
}
