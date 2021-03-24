resource "kubernetes_service" "internal-service" {
  metadata {
    name      = "internal-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.internal-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8082
      target_port = 8082
    }

    type = "ClusterIP"
  }
}
output "ClusterIP_status" {
  value = kubernetes_service.internal-service.status
}
