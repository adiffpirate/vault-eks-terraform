![Build Status](https://github.com/adiffpirate/vault-eks-terraform/actions/workflows/static_analysis.yaml/badge.svg?branch=develop)

# Vault on EKS with Terraform

The `.tfstate` file for this project is stored in a encrypted S3 bucket.
To create said bucket please refer to the `backend` directory.

Since we can't use variables to define the bucket name, region, and some other
things, **in order to properly intialize terraform you must use the following
script** _(instead of the usual `terraform init` command)_:
```sh
./terraform_init {YOUR_TFVARS_FILE}
```

> By default, the script uses `terraform.tfvars`

Then, you can spin up the infrastructure:
```sh
terraform apply
```
