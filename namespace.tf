provider "kubernetes" {
  config_path    = pathexpand(var.kind_cluster_config_path)
  config_context = "kind-terraform"
}

resource "kubernetes_namespace" "jenkins_ns" {
  metadata {
    annotations = {
      name = "jenkins-annotation"
    }
    labels = {
      "kubernetes.io/metadata.name" = "jenkins"
    }
    name = "jenkins"
  }
}