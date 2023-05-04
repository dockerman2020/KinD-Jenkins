provider "kubectl" {
}

resource "kubernetes_manifest" "clusterrole_jenkins_admin" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "name" = "jenkins-admin"
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "serviceaccount_devops_tools_jenkins_admin" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "name" = "jenkins-admin"
      "namespace" = "jenkins"
    }
  }
}

resource "kubernetes_manifest" "clusterrolebinding_jenkins_admin" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "name" = "jenkins-admin"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "jenkins-admin"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "jenkins-admin"
        "namespace" = "jenkins"
      },
    ]
  }
}