context = {
  project = "luiz-monteiro-vaultdemo"
  environment = "development"
  region = "eu-west-1"
}

database = {
  identifier = "luiz-monteiro-vaultdemo"
  name = "mysqldev"
  username = "admin"
  sg = {
    name             = "luiz-monteiro-vaultdemo-mysql-sg"
    cidr_blocks      = ["0.0.0.0/0"] # Allow connections from anywhere (insecure)
  }
}
