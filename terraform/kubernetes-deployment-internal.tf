resource "kubernetes_deployment" "internal-deployment" {
  metadata {
    name = "internal-deployment"
    labels = {
      App = "internal"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 4
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "internal"
        }
      }
      spec {
        container {
          image = "mhnj7/internal:v1.0"
          name  = "internal"

          port {
            container_port = 8082
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
