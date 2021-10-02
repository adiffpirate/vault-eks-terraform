output "context" {
  value = local.context
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_private_subnets_ids" {
  description = "IDs for the private subnets on the VPC"
  value       = module.vpc.private_subnets
}
