output "release_name" {
  description = "Helm Release Name"
  value       = local.vault_metadata.name
}

output "namespace" {
  description = "Kubernetes Namespace where Vault was deployed"
  value       = local.vault_metadata.namespace
}

output "version" {
  description = "Version of the Vault application"
  value       = local.vault_metadata.app_version
}

output "server_url" {
  description = "Vault Server URL"
  value       = "http://${data.kubernetes_service.vault_server.status[0].load_balancer[0].ingress[0].hostname}:8200"
}

# Can be useful for debugging
# output "helm_release" {
#   value = {
#     # Version of the Chart used for this release
#     version = local.vault_metadata.version
#     # The compounded values from `values` and `set*` attributes
#     values = jsondecode(local.vault_metadata.values)
#   }
# }
