include {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/sebastianneb-streamedcon2020/terraform-module-github-actions-gcloud?ref=v1.4.0"
}

dependency "seed_project" {
  config_path = "../bootstrap"
}

inputs = {
  project_id = dependency.seed_project.outputs.seed_project_id
  name = "organization-structure"
  description = "Repository to manage the organization"
  bucket = dependency.seed_project.outputs.gcs_bucket_tfstate
  service_account_email = dependency.seed_project.outputs.terraform_sa_email
  github_token = get_env("GITHUB_TOKEN")
  github_owner = get_env("GITHUB_OWNER")
  github_template_owner = get_env("GITHUB_OWNER")
  github_template_repository = get_env("GITHUB_TEMPLATE_REPOSITORY")
}
