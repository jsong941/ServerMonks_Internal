resource "kubernetes_deployment" "external-deployment" {
  metadata {
    name = "external-deployment"
    labels = {
      App = "external"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "external"
      }
    }
    template {
      metadata {
        labels = {
          App = "external"
        }
      }
      spec {
        container {
          image = "mhnj7/external:v2.0"
          name  = "external"
          port {
            container_port = 80
          }
          env {
            name  = "SERVER"
            value = "http://internal-service:8082"
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
