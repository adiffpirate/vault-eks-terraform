module "network" {
  source = "../../modules/network"

  context     = var.context
  network     = var.network
  eks_cluster = var.eks_cluster
}

module "eks_cluster" {
  source = "../../modules/eks_cluster"

  context     = var.context
  network     = module.network
  eks_cluster = var.eks_cluster
}

module "consul" {
  source = "../../modules/consul"

  consul = var.consul
}

module "vault" {
  source = "../../modules/vault"

  vault = var.vault
}
