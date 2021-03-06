variable "context" {
  type = object({

    # Project Name
    project = string

    # Environment
    environment = string

  })
}

variable "database" {
  type = object({

    # Name of the RDS instance
    identifier = string

    # Name of the database that will be created
    name = string

    # Username that will be created to access the database
    username = string

    # Determine if the database should be replicated between availability zones
    multi_az = bool

    # Security Group
    sg = object({
      name        = string
      cidr_blocks = list(string)
    })

  })
}
