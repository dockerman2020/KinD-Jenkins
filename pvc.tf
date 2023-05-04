resource "kubernetes_manifest" "persistentvolumeclaim_devops_tools_jenkins_pv_claim" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolumeClaim"
    "metadata" = {
      "name" = "jenkins-pv-claim"
      "namespace" = "jenkins"
    }
    "spec" = {
      "accessModes" = [
        "ReadWriteOnce",
      ]
      "resources" = {
        "requests" = {
          "storage" = "3Gi"
        }
      }
      "storageClassName" = "local-storage"
    }
  }
  depends_on = [
     kubernetes_manifest.persistentvolume_jenkins_pv_volume 
     ]
}

# resource "kubernetes_manifest" "persistentvolumeclaim_my_claim" {
#   manifest = {
#     "apiVersion" = "v1"
#     "kind" = "PersistentVolumeClaim"
#     "metadata" = {
#       "annotations" = {
#         "pv.kubernetes.io/bind-completed" = "yes"
#         "pv.kubernetes.io/bound-by-controller" = "yes"
#       }
#       "name" = "jenkins-pv-claim"
#       "namespace" = "jenkins"
#     }
#     "spec" = {
#       "accessModes" = [
#         "ReadWriteOnce",
#       ]
#       "resources" = {
#         "requests" = {
#           "storage" = "1Gi"
#         }
#       }
#       "storageClassName" = "standard"
#       "volumeMode" = "Filesystem"
#       "volumeName" = "jenkins-pv"
#     }
#   }
# }