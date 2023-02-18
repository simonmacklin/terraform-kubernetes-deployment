resource "kubernetes_manifest" "rule" {
  for_each = { for rule in var.prometheus_rules : rule.name => rule }
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "name"    = format("%s-%s", var.name, each.value["name"])
      namespace = var.namespace
      "labels" = {
        "prometheus" = "example"
        "role"       = "alert-rules"
      }

    }
    "spec" = {
      "groups" = [
        {
          "name" = each.value["name"]
          "rules" = [
            {
              "alert" = each.value["name"]
              "expr"  = each.value["expr"]
            },
          ]
        },
      ]
    }
  }
}