resource "kubernetes_manifest" "deployment_devops_tools_jenkins" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "jenkins"
      "namespace" = "jenkins"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "jenkins-server"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "jenkins-server"
          }
        }
        "spec" = {
          "containers" = [
            {
              # "image" = "jenkins/jenkins:lts"
              # "image" = "jenkins/jenkins:2.387.3-lts-jdk11@sha256:e34a63e1292b70f23e4393d7d7405e7e7ec7108d2faf16496b977461f9232f99"
              "image" = "dockerman2002/jenkins-lts:latest"
              "livenessProbe" = {
                "failureThreshold" = 5
                "httpGet" = {
                  "path" = "/login"
                  "port" = 8080
                }
                "initialDelaySeconds" = 90
                "periodSeconds" = 10
                "timeoutSeconds" = 5
              }
              "name" = "jenkins"
              "ports" = [
                {
                  "containerPort" = 8080
                  "name" = "httpport"
                },
                {
                  "containerPort" = 50000
                  "name" = "jnlpport"
                },
              ]
              "readinessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/login"
                  "port" = 8080
                }
                "initialDelaySeconds" = 60
                "periodSeconds" = 10
                "timeoutSeconds" = 5
              }
              "resources" = {
                "limits" = {
                  "cpu" = "2"
                  "memory" = "4Gi"
                }
                "requests" = {
                  "cpu" = "1"
                  "memory" = "2Gi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/jenkins_home"
                  "name" = "jenkins-data"
                },
              ]
            },
          ]
          "securityContext" = {
            "fsGroup" = 1000
            "runAsUser" = 1000
          }
          "serviceAccountName" = "jenkins-admin"
          "volumes" = [
            {
              "name" = "jenkins-data"
              "persistentVolumeClaim" = {
                "claimName" = "jenkins-pv-claim"
              }
            },
          ]
        }
      }
    }
  }
  depends_on = [ 
    kubernetes_manifest.persistentvolumeclaim_devops_tools_jenkins_pv_claim
    ]
}