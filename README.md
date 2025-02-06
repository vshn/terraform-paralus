# VSHN Terraform Module Paralus

This module does the following:

* Create a Cluster in Paralus

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
```

Needs to be added to `variables.tf`

```hcl
variable "PARALUS_API_KEY" {
  description = "API Key for Paralus"
  type        = string
}

variable "PARALUS_API_SECRET" {
  description = "API Secret for Paralus"
  type        = string
}

variable "paralus_kubernetes_provider" {
  description = "Kubernetes Provider, for instance GKE or EKS"
  type        = string
}

variable "paralus_project_name" {
  description = "Name of the Paralus project"
  type        = string
  default     = ""
}
```

Needs to be added to `versions.tf`

```hcl
    paralus = {
      source  = "iherbllc/paralus"
      version = "0.0.48"
    }
```

Neeeds to be added to `.gitlab-ci.yml`

```hcl
TF_VAR_PARALUS_API_KEY: $PARALUS_API_KEY
TF_VAR_PARALUS_API_SECRET: $PARALUS_API_SECRET
```

Needs to be added to `.tfvars`

```hcl
paralus_kubernetes_provider = "foo"
paralus_project_name        = "bar"
```
