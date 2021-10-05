output "release_name" {
  description = "Helm Release Name"
  value       = local.consul_metadata.name
}

output "namespace" {
  description = "Kubernetes Namespace where Consul was deployed"
  value       = local.consul_metadata.namespace
}

output "version" {
  description = "Version of the Consul application"
  value       = local.consul_metadata.app_version
}

# Can be useful for debugging
# output "helm_release" {
#   value = {
#     # Version of the Chart used for this release
#     version = local.consul_metadata.version
#     # The compounded values from `values` and `set*` attributes
#     values = jsondecode(local.consul_metadata.values)
#   }
# }
