# Development Environment

Spin up the infrastructure:
```sh
terraform apply
```

Configure kubectl:
```sh
aws eks --region $(terraform output -json context | jq -r .region) \
	update-kubeconfig --name $(terraform output -json eks_cluster | jq -r .name)
```
