
#locals {
#  tf_sa = var.project_service_account
#}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.19"
    }
  }
}

provider "google" {
  
  # Options to use:

  # 1. Use nothing to use current authenticated user

  # 2. Use credentials and down load a key from a service account if needed
  credentials = file(var.credentials_file)

  # 3. Use impersonate_service_account to install as the service account where our account is granted access or CICD in use
  #  impersonate_service_account = local.tf_sa
}




