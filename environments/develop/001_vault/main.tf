module "network" {
  source = "../../../modules/network"

  context     = var.context
  network     = var.network
  eks_cluster = var.eks_cluster
}

module "eks_cluster" {
  source     = "../../../modules/eks_cluster"
  depends_on = [module.network]

  context     = var.context
  network     = module.network
  eks_cluster = var.eks_cluster
}

module "consul" {
  source     = "../../../modules/consul"
  depends_on = [module.eks_cluster]

  consul = var.consul
}

module "vault" {
  source     = "../../../modules/vault"
  depends_on = [module.consul]

  context     = var.context
  network     = module.network
  eks_cluster = module.eks_cluster
  vault       = var.vault
}
