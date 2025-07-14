output "jenkins_service_name" {
  description = "Jenkins Helm release name (used for service lookup)"
  value       = helm_release.jenkins.name
}

output "jenkins_admin_password_info" {
  description = "Command to retrieve the Jenkins admin password"
  value       = "kubectl get secret --namespace jenkins jenkins -o jsonpath=\"{.data.jenkins-admin-password}\" | base64 --decode"
}

