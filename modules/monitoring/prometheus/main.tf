resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "45.0.0"
  namespace        = "monitoring"
  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}
