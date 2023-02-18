data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "selected" {
  name = var.stack
}

data "aws_eks_cluster_auth" "selected" {
  name = data.aws_eks_cluster.selected.id
}

locals {
  oidc_issuer_url = replace(data.aws_eks_cluster.selected.identity[0].oidc[0].issuer, "https://", "")
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${local.oidc_issuer_url}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.name}"]
    }
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_issuer_url}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "role" {
  name                 = format("%s-%s-role", var.name, var.stack)
  max_session_duration = var.iam_role_max_session_duration
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name   = format("%s-%s-policy", var.name, var.stack)
    policy = var.iam_policy
  }
}
