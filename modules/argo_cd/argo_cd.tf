provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  namespace  = "argocd"
  create_namespace = true
  chart      = "argo/argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.36.3"

  values = [
    file("${path.module}/values.yaml")
  ]
}

