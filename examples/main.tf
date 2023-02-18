provider "kubernetes" {
  config_path = "/Users/simon/.kube/config"
}

module "event_proxy" {
  source    = "../"
  name      = "conductor-worker"
  namespace = "default"
  image     = "nginx"
  ports = [
    {
      name           = "app"
      container_port = 80
      service_port   = 5000
    }
  ]
  env = {
    "hello"   = "a"
    "ashello" = "v"
  }
  ingress_rules = [
    {
      name = "app"
      path = "/"
      host = "*"
    }
  ]
  service_monitor = {
    port     = 80
    path     = "/metrics"
    interval = "10s"
  }
}

