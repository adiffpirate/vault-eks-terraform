terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_kms_key" "terraform_state_encryption_key" {
  description = "Key used to encrypt/decrypt the terraform state bucket objects"

  is_enabled          = true
  enable_key_rotation = true

  tags = {
    Name    = "${var.project}-kms-terraform-state"
    project = var.project
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project}-terraform-state"
  acl    = "private"

  lifecycle {
    # Set this to true for production environments
    prevent_destroy = false
  }
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.terraform_state_encryption_key.arn
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = {
    Name    = "${var.project}-s3-terraform-state"
    project = var.project
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "${var.project}-terraform-state-lock"

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "${var.project}-dynamodb-terraform-state-lock"
    project = var.project
  }
}
