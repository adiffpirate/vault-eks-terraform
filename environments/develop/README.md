# Development Environment

## Vault

1. Enter Vault directory
```sh
cd 001_vault
```

2. Spin up the EKS cluster with Vault:
```sh
terraform apply
```

3. Configure kubectl:
```sh
aws eks --region $(terraform output -json context | jq -r .region) \
	update-kubeconfig --name $(terraform output -json eks_cluster | jq -r .name)
```

4. Initialize Vault:
```sh
kubectl -n vault exec -ti {VAULT_POD_NAME} -- vault operator init
```
