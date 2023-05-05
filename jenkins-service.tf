resource "kubernetes_manifest" "service_jenkins_jenkins_service" {
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
      "ipFamilies" = [
        "IPv4",
      ]
      "ipFamilyPolicy" = "SingleStack"
      "ports" = [
        {
          "name" = "http"
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = 8080
        },
        {
          "name" = "jnlp"
          "port" = 50000
          "protocol" = "TCP"
          "targetPort" = 50000
        },
        {
          "name" = "jenport"
          "port" = 8080
          "protocol" = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "jenkins-server"
      }
      "sessionAffinity" = "None"
      "type" = "ClusterIP"
    }
  }
}

# resource "kubernetes_manifest" "service_devops_tools_jenkins_service" {
#   manifest = {
#     "apiVersion" = "v1"
#     "kind" = "Service"
#     "metadata" = {
#       "annotations" = {
#         "prometheus.io/path" = "/"
#         "prometheus.io/port" = "8080"
#         "prometheus.io/scrape" = "true"
#       }
#       "name" = "jenkins-service"
#       "namespace" = "jenkins"
#     }
#     "spec" = {
#       "ports" = [
#         {
#           "port" = 80
#           "targetPort" = 8080
#         },
#         {
#           "port" = 8080
#           "targetPort" = 8080
#         },
#         {
#           "port" = 50000
#           "targetPort" = 50000
#         },
#       ]
#       "selector" = {
#         "app" = "jenkins-server"
#       }
#       "type" = "ClusterIP"
#     }
#   }
# }
