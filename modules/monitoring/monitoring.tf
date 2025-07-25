resource "helm_release" "prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "58.0.1" 

  values = [
    file("${path.module}/values-prometheus.yaml")
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "monitoring"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "7.3.10" # перевірити актуальну

  values = [
    file("${path.module}/values-grafana.yaml")
  ]

  depends_on = [helm_release.prometheus]
}

