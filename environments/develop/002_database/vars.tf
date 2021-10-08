variable "context" {
  type = object({

    # Project Name
    project = string

    # Region
    region = string

    # Environment
    environment = string

  })
}

# Each module has its own vars.tf that defines the variables as objects
# So here we just need to pass a reference to each object

variable "database" {
  type = any
}
