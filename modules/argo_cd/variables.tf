variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  type        = string
}

variable "cluster_ca_cert" {
  description = "The base64 encoded CA certificate for the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "The namespace where Argo CD will be deployed"
  type        = string
  default     = "argocd"
}

