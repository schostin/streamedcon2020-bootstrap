terraform {
  required_version = "0.12.28"
  required_providers {
    gsuite = "0.1.52"
  }
}

provider "gsuite" {
  # impersonated_user_email = var.impersonated_user_email
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.user"
  ]
}

resource "gsuite_group" "organization_admins" {
  email       = "organization-admins@${var.domain}"
  name        = "organization-admins"
  description = "Organization Admins"
}

resource "gsuite_group" "billing_admins" {
  email       = "billing-admins@${var.domain}"
  name        = "billing-admins"
  description = "Billing admins"
}
