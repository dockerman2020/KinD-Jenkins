resource "kubernetes_manifest" "persistentvolume_jenkins_pv_volume" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolume"
    "metadata" = {
      "labels" = {
        "type" = "local"
      }
      "name" = "jenkins-pv-volume"
    }
    "spec" = {
      "accessModes" = [
        "ReadWriteOnce",
      ]
      "capacity" = {
        "storage" = "10Gi"
      }
      "claimRef" = {
        "name" = "jenkins-pv-claim"
        "namespace" = "jenkins"
      }
      "local" = {
        "path" = "/jenkins_data"
      }
      "nodeAffinity" = {
        "required" = {
          "nodeSelectorTerms" = [
            {
              "matchExpressions" = [
                {
                  "key" = "kubernetes.io/hostname"
                  "operator" = "In"
                  "values" = [
                    "terraform-worker",
                    "terraform-worker2",
                    "terraform-worker3",
                  ]
                },
              ]
            },
          ]
        }
      }
      "storageClassName" = "local-storage"
    }
  }
  depends_on = [ 
    kubernetes_manifest.storageclass_local_storage 
    ]
}