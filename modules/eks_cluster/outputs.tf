output "context" {
  value = local.context
}

output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.eks_cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  description = "Kubectl config as generated by the module."
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.eks.config_map_aws_auth
}

output "ca_certificate" {
  description = "PEM-encoded root certificates bundle for TLS authentication."
  value       = data.aws_eks_cluster.eks.certificate_authority[0].data
  sensitive   = true
}

output "service_account_token" {
  description = "Service Account Token"
  value       = data.aws_eks_cluster_auth.eks.token
  sensitive   = true
}
