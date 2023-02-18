resource "kubernetes_ingress_v1" "ingress" {
  count = length(var.ingress_rules) > 0 ? 1 : 0
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  spec {
    dynamic "rule" {
      for_each = var.ingress_rules
      content {
        http {
          path {
            path      = rule.value["path"]
            path_type = rule.value["path_type"]
            backend {
              service {
                name = kubernetes_service.service.metadata[0].name
                port {
                  name = rule.value["name"]
                }
              }
            }
          }
        }
      }
    }
  }
}