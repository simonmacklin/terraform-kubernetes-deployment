
data "aws_eks_cluster" "selected" {
  name = "dev-k8s-fil"
}

data "aws_eks_cluster_auth" "selected" {
  name = data.aws_eks_cluster.selected.id
}

provider "aws" {}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.selected.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.selected.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.selected.token
}

module "simple_service" {
  source    = "../../"
  name      = "simple-service"
  stack     = "dev-k8s-fil"
  namespace = "default"
  image     = "nginx"
  env = {
    "KAFKA_HOST" = "kafka.data-platform"
  }
}

