include {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/terraform-google-modules/terraform-google-bootstrap?ref=v1.1.0"
}

inputs = {
  group_org_admins      = get_env("GROUP_ORG_ADMINS")
  group_billing_admins  = get_env("GROUP_BILLING_ADMINS")
  default_region        = "europe-west3"
  project_prefix        = "sebastianneb"
  activate_apis = [
    "cloudbilling.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudtrace.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "dns.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "secretmanager.googleapis.com",
    "serviceusage.googleapis.com",
    "stackdriver.googleapis.com",
    "storage-api.googleapis.com",
  ]
  sa_org_iam_permissions = [
    "roles/billing.user",
    "roles/cloudbuild.builds.builder",
    "roles/compute.networkAdmin",
    "roles/compute.xpnAdmin",
    "roles/iam.securityAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/logging.configWriter",
    "roles/orgpolicy.policyAdmin",
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.organizationViewer",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter",
    "roles/resourcemanager.projectIamAdmin",
    "roles/resourcemanager.projectMover",
  ]
}