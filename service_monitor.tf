
resource "kubernetes_manifest" "monitor" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata" = {
      "labels" = {
        "serviceMonitorSelector" = "s"
      }
      "name"      = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "endpoints" = [
        {
          "interval"   = var.service_monitor.interval
          "path"       = var.service_monitor.path
          "targetPort" = var.service_monitor.port
        },
      ]
      "namespaceSelector" = {
        "matchNames" = [
          var.namespace
        ]
      }
      "selector" = {
        "matchLabels" = {
          "operated-prometheus" = "true"
        }
      }
    }
  }
}
