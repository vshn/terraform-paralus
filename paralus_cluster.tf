resource "paralus_cluster" "cluster" {
  name         = var.cluster_name
  project      = var.paralus_project_name
  cluster_type = "imported"
  params {
    provision_type        = "IMPORT"
    provision_environment = "CLOUD"
    kubernetes_provider   = var.kubernetes_provider
    state                 = "PROVISION"
  }
}