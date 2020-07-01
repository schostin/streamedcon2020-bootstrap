remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "terraform.tfstate"
  }
}

inputs = {
  org_id          = get_env("ORG_ID")
  billing_account = get_env("BILLING_ACCOUNT")
  domain          = get_env("DOMAIN")
}
