resource "kubectl_manifest" "hello-ingress" {
    yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jenkins-ingress
  namespace: jenkins
spec:
  ingressClassName: nginx
  rules:
  - host: "inst1.absi.test"
    http:
      paths:
        - pathType: Prefix
          path: "/"
          backend:
            service:
              name: jenkins-service
              port:
                number: 80
YAML
depends_on = [ 
    kubernetes_manifest.deployment_jenkins
     ]
}