provider "kubernetes" {
  config_path    = pathexpand(var.kind_cluster_config_path)
  config_context = "kind-terraform"
}

data "kubernetes_resource" "jenkins_ns" {
  api_version = "v1"
  kind        = "Namespace"
  metadata {
    name      = "jenkins"
    namespace = "jenkins"
  }
}

data "kubernetes_resource" "jenkins-worker_ns" {
  api_version = "v1"
  kind        = "Namespace"
  metadata {
    name      = "jenkins-worker"
    namespace = "jenkins-worker"
  }
}