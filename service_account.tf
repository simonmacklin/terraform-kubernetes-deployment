
locals {
  service_iam_annotations = {
     "eks.amazonaws.com/role-arn" = aws_iam_role.role.arn
  }
} 

resource "kubernetes_service_account_v1" "service_account" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = merge(var.service_annotations, local.service_iam_annotations)
  }

  automount_service_account_token = true
}
