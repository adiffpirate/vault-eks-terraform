# Each module has its own vars.tf that defines the variables as objects
# So here we just need to pass a reference to each object

variable "context" {
  type = any
}

variable "network" {
  type = any
}

variable "eks_cluster" {
  type = any
}

variable "consul" {
  type = any
}

variable "vault" {
  type = any
}
