
data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "selected" {
  name = data.aws_eks_cluster.selected.id
}

data "aws_eks_cluster" "selected" {
  name = "dev-k8s-fil"
}

provider "aws" {

}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.selected.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.selected.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.selected.token
}

module "event_proxy" {
  source    = "../"
  name      = "conductor-worker"
  stack = "dev-k8s-fil"
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

