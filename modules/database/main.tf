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

data "vault_generic_secret" "static_db_creds" {
  depends_on = [vault_generic_secret.static_db_creds]

  path = local.vault.static_kv.database.creds_path
}

resource "aws_db_instance" "mysql" {
  identifier          = var.database.identifier
  name                = var.database.name
  instance_class      = "db.t3.micro"
  allocated_storage   = "5"
  engine              = "mysql"
  username            = data.vault_generic_secret.static_db_creds.data["username"]
  password            = data.vault_generic_secret.static_db_creds.data["password"]
  skip_final_snapshot = true
  
  publicly_accessible    = true # Potential security risk, use with caution
  vpc_security_group_ids = [aws_security_group.mysql.id]

  tags = {
    project     = var.context.project
    environment = var.context.environment
  }
}

resource "aws_security_group" "mysql" {
  description = "Allow connections to MySQL database on RDS"
  name        = var.database.sg.name

  ingress {
    description = "Connections to MySQL DB from a CIDR block defined as variable in terraform"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.database.sg.cidr_blocks
  }

  tags = {
    project     = var.context.project
    environment = var.context.environment
  }
}
