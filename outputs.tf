output "name" {
  value = var.name
}

output "namespace" {
  value = kubernetes_deployment.deploy.metadata[0].namespace
}

output "service_name" {
  value = kubernetes_service.service.metadata[0].name
}

