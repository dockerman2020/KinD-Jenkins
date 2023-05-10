resource "kubernetes_manifest" "storageclass_local_storage" {
  manifest = {
    "apiVersion" = "storage.k8s.io/v1"
    "kind" = "StorageClass"
    "metadata" = {
      "name" = "local-storage"
    }
    "provisioner" = "kubernetes.io/no-provisioner"
    "reclaimPolicy" = "Retain"
    "volumeBindingMode" = "WaitForFirstConsumer"
  }
  depends_on = [ 
    # kubernetes_namespace.jenkins_ns,
    data.kubernetes_resource.jenkins_ns
     ]
}
