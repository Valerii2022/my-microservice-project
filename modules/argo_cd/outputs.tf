output "argo_cd_url" {
  value = "http://argo-cd.${var.namespace}.svc.cluster.local:8080"
}

output "argo_cd_admin_password" {
  value = "admin123"
}

