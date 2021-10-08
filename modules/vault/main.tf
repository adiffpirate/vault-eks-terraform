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

resource "helm_release" "vault" {
  name = var.vault.release_name

  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = var.vault.helm_chart.version

  namespace        = var.vault.namespace
  create_namespace = true

  values = [
    file("${path.module}/${var.vault.helm_chart.values_filepath}")
  ]

  # Vault Server Configuration (declared here so we can use Auto Unseal via KMS)
  set {
    name = "server.ha.config"
    value = <<EOF
    api_addr = "http://POD_IP:8200"
    listener "tcp" {
      tls_disable     = 1
      address         = "[::]:8200"
      cluster_address = "[::]:8201"
    }
    storage "consul" {
      path = "vault"
      address = "HOST_IP:8500"
    }
    seal "awskms" {
      region = "${var.context.region}"
      kms_key_id = "${aws_kms_key.vault_unseal.key_id}"
    }
    service_registration "kubernetes" {}
    EOF
  }

  # Set overrides from .tfvars
  dynamic "set" {
    for_each = var.vault.helm_chart.override
    content {
      name  = set.key
      value = set.value
    }
  }
}

# Vault Server Data
data "kubernetes_service" "vault_server" {
  metadata {
    name      = "vault-active"
    namespace = var.vault.namespace
  }
}

locals {
  # The resource helm_release defines metadata as a list, so we're retrieving the last element from it
  vault_metadata = helm_release.vault.metadata[length(helm_release.vault.metadata)-1]
}
