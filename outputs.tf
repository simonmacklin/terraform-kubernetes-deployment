output "name" {
  value = var.name
}

output "namespace" {
  value = kubernetes_deployment.deploy.metadata[0].namespace
}

output "service_name" {
  value = var.name
  depends_on = [
    kubernetes_service.service
  ]
}

output "ports" {
  value = { for port in var.ports : port.port => port }
}