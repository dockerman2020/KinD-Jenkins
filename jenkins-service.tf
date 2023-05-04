resource "kubernetes_manifest" "service_devops_tools_jenkins_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "annotations" = {
        "prometheus.io/path" = "/"
        "prometheus.io/port" = "8080"
        "prometheus.io/scrape" = "true"
      }
      "name" = "jenkins-service"
      "namespace" = "jenkins"
    }
    "spec" = {
      "ports" = [
        {
          # "nodePort" = 32000
          "port" = 80
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "jenkins-server"
      }
      "type" = "ClusterIP"
    }
  }
}
