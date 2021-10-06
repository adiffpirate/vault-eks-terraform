output "id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "name" {
  description = "EKS Cluster Name"
  value       = var.eks_cluster.name
}

output "version" {
  description = "EKS Cluster Version"
  value       = var.eks_cluster.version
}

output "endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "security_group_id" {
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

output "workers" {
  value = {
    # IAM role
    iam_role = {
      name = module.eks.worker_iam_role_name
      arn  = module.eks.worker_iam_role_arn
    }
  }
}


# All sensitive data MUST be declared inside this object.
# (for more information please refer to the root 'outputs.tf' file)
output "sensitive" {
  sensitive = true
  value = {

    # PEM-encoded root certificates bundle for TLS authentication
    ca_certificate = data.aws_eks_cluster.eks.certificate_authority[0].data

    # EKS Auth Token
    auth_token = data.aws_eks_cluster_auth.eks.token

  }
}
