# The for loop creates a new object removing the inner-object called "sensitive".
# We do that in order to print the non-sensitive values of an object that contains sensitive data inside.
# Basically a workaround for https://github.com/hashicorp/terraform/issues/28222

output "context" {
  value = var.context
}

output "network" {
  value = module.network
}

output "eks_cluster" {
  value = {
    for key, value in module.eks_cluster : key => value
    if key != "sensitive"
  }
}

output "sensitive" {
  sensitive = true
  value = {
    eks_cluster = module.eks_cluster.sensitive
  }
}
