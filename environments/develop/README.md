# Development Environment

> **ATENTION: In this environment the terraform.tfstate only exists locally, so take care of it :)**

**Requirements:**
  - [AWS CLI](https://aws.amazon.com/cli/)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
  - [Vault CLI](https://www.vaultproject.io/docs/install)

## Vault

1. Enter Vault directory:
```sh
cd 001_vault
```

2. Configure AWS CLI:
```sh
aws configure
```

3. Create your `.tfvars` file:
```sh
cp terraform.tfvars.example my_variables.tfvars
```

4. Initialize Terraform
```sh
terraform init
```

5. Spin up the EKS cluster with Vault:
```sh
terraform apply -var-file="my_variables.tfvars"
```

6. Configure kubectl:
```sh
aws eks --region $(terraform output -json context | jq -r .region) \
	update-kubeconfig --name $(terraform output -json eks_cluster | jq -r .name)
```

7. Initialize Vault:
```sh
kubectl -n vault exec -ti vault-0 -- vault operator init -format json | tee $HOME/.vault_keys.json
```

8. Get Vault address and token:
```sh
export VAULT_ADDR=$(terraform output -json vault | jq -r .server_url)
```
```sh
export VAULT_TOKEN=$(cat $HOME/.vault_keys.json | jq -r .root_token)
```

## Database

9. Enter Database directory
```sh
cd ../002_database
```

10. Create your `.tfvars` file:
```sh
cp terraform.tfvars.example my_variables.tfvars
```

11. Initialize Terraform
```sh
terraform init
```

12. Deploy:
```sh
terraform apply -var-file="my_variables.tfvars"
```
