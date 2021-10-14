resource "vault_mount" "static_kv" {
  description = "Enable static KV secrets for database creation"

  path = "static"
  type = "kv-v2"
}

resource "random_password" "generate_db_password" {
  length  = 20
  special = true

  override_special = "!#$%&*()-+=_"
}

locals {
  vault = {
    static_kv = {
      database = {
        creds_path = "${vault_mount.static_kv.path}/database"
      }
    }
  }
}

resource "vault_generic_secret" "static_db_creds" {
  path = local.vault.static_kv.database.creds_path

  data_json = <<EOT
{
  "username": "${var.database.username}",
  "password": "${random_password.generate_db_password.result}"
}
EOT
}
