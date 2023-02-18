
locals {
  service_iam_annotations = {}
}

resource "kubernetes_service_account_v1" "service_account" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = merge(var.service_annotations, local.service_iam_annotations)
  }

  automount_service_account_token = true
}
