
resource "kubernetes_service" "service" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  spec {
    type             = var.service_type
    session_affinity = "ClientIP"
    dynamic "port" {
      for_each = var.ports
      content {
        name         = lookup(port.value, "name", null)
        port         = lookup(port.value, "service_port")
        app_protocol = lookup(port.value, "protocol", null)
        target_port  = port.value["container_port"]
      }
    }
    publish_not_ready_addresses = false
    selector                    = local.labels
  }

}
