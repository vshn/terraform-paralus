variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "paralus_project_name" {
  description = "Name of the paralus project"
  type        = string
  default     = ""
}

variable "kubernetes_provider" {
  description = "Kubernetes Provider, for instance GKE or EKS"
  type        = string
}