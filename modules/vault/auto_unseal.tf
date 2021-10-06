# Unseal key on KMS

resource "aws_kms_key" "vault_unseal" {
  description = "Key used to unseal Vault"
  is_enabled  = true

  enable_key_rotation     = true
  deletion_window_in_days = 7

  tags = {
    project     = var.context.project
    environment = var.context.environment
  }
}

# Policy that allows access to unseal key

data "aws_iam_policy_document" "vault_unseal_kms" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]

    resources = [aws_kms_key.vault_unseal.arn]
  }
}

# Add policy to the EKS Workers IAM role

resource "aws_iam_role_policy" "vault_auto_unseal_kms" {
  name = "${var.context.project}-vault-unseal-kms-policy"

  role  = var.eks_cluster.workers.iam_role.name
  policy = element(
    concat(
      data.aws_iam_policy_document.vault_unseal_kms.*.json,
      [""],
    ),
    0,
  )
}

