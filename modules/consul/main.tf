terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.3.0"
    }
  }
}

resource "helm_release" "consul" {
  name = var.consul.release_name

  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  version    = var.consul.helm_chart.version

  namespace        = var.consul.namespace
  create_namespace = true

  values = [
    file("${path.module}/${var.consul.helm_chart.values_filepath}")
  ]

  dynamic "set" {
    for_each = var.consul.helm_chart.override
    content {
      name  = set.key
      value = set.value
    }
  }
}

locals {
  # The resource helm_release defines metadata as a list, so we're retrieving the last element from it
  consul_metadata = helm_release.consul.metadata[length(helm_release.consul.metadata)-1]
}
