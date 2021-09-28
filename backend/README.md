# Terraform Backend

Create an encrypted S3 bucket to store the `terraform.tfstate` and a DynamoDB
table to store a variable that manages the write access to said bucket.

The configuration declared here only needs to be applied once.

```sh
terraform init
```

```sh
terraform apply
```
