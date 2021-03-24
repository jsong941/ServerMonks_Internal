resource "kubernetes_namespace" "n" {
  metadata {
    name = "dev1"
  }
}
