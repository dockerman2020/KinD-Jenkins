resource "kubernetes_manifest" "persistentvolumeclaim_jenkins_pv_claim" {
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
