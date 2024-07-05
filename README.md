# VSHN Terraform Module Paralus

This module does the following:

* Create a Cluster in Paralus
* Output bootstrap URL to be applied on the cluster

## Preparation

Before applying, the customer group and project must exist in Paralus.

* Create a group per customer matching the keycloak group name
* Create a project per customer matching the keycloak group name
* Assign the newly created group to the project with Role "Project Admin"
* Create a local user for terraform (email address customername@paralus.vshn.ch)
* Assign local user to project with Role "Project Admin"
* Create API key for local user to be used in terraform

## Example usage

Needs to be added to `main.tf`.

```hcl
provider "paralus" {
  pctl_profile       = "prod"
  pctl_rest_endpoint = "console.paralus.vshn.ch:443"
  pctl_ops_endpoint  = "console.paralus.vshn.ch:443"
  pctl_api_key       = var.PARALUS_API_KEY
  pctl_api_secret    = var.PARALUS_API_SECRET
  pctl_partner       = "Paralus"
  pctl_organization  = "VSHN AG"
}

module "paralus" {
  source = "git::ssh://git@git.vshn.net/vshn-terraform/module-paralus.git?ref=v1.0.0"

  cluster_name         = terraform.workspace
  kubernetes_provider  = var.paralus_kubernetes_provider
  paralus_project_name = var.paralus_project_name
}

output "paralus" {
  value = module.paralus
}
```
