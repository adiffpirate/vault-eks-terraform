terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.24.0"
    }
  }
}

# Providers

provider "aws" {
  region = var.context.region
}

provider "vault" {
  # The address and token are configured via environment variables for security reasons.
  # So use VAULT_ADDR and VAULT_TOKEN :)
  skip_tls_verify = true
}

# Modules

module "database" {
  source = "../../../modules/database"

  context  = var.context
  database = var.database
}
