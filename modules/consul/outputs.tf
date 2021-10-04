output "release_name" {
  description = "Helm Release Name"
  value       = helm_release.consul.metadata[0].name
}

output "namespace" {
  description = "Kubernetes Namespace where Consul was deployed"
  value       = helm_release.consul.metadata[0].namespace
}

output "version" {
  description = "Version of the Consul application"
  value       = helm_release.consul.metadata[0].app_version
}

# output "helm_release" {
#   value = {
#     # Version of the Chart used for this release
#     version = helm_release.consul.metadata[0].version
#     # The compounded values from `values` and `set*` attributes
#     values = jsondecode(helm_release.consul.metadata[0].values)
#   }
# }
