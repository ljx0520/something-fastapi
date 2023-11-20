resource "google_service_account" "github_actions" {
  account_id   = "github-action"
  display_name = "GitHub Actions for CI/CD"
}

resource "google_project_iam_member" "github_actions" {
  for_each = toset([
    "roles/cloudbuild.builds.builder",
    "roles/cloudfunctions.developer",
    "roles/run.admin", # if you want to deploy allow-unauthenticated runs
    "roles/workflows.editor",
    "roles/iam.serviceAccountUser", # required to deploy functions with service accounts
    "roles/serviceusage.serviceUsageConsumer", # required to access cloud build
    "roles/viewer"
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

module "github_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "github"
  provider_id = "github-provider"
  sa_mapping  = {
    "github_action" = {
      sa_name   = "projects/${var.project_id}/serviceAccounts/${google_service_account.github_actions.email}"
      attribute = "attribute.repository/ljx0520/something-fastapi"
    }
  }
}