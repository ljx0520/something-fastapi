### Cloud Runs ###

resource "google_service_account" "something-fastapi" {
  account_id   = "something-fastapi"
  display_name = "Something FastAPI API Service Account"
}

resource "google_project_iam_member" "something-fastapi" {
  for_each = toset([
    "roles/datastore.user", # has to be project-level, no resource-level IAM binding
    "roles/secretmanager.admin", # has to be project-level, interacts with dynamic set of secrets
  ])
  role    = each.key
  member  = "serviceAccount:${google_service_account.something-fastapi.email}"
  project = var.project_id
}

### Secrets ###

# The secret version is added manually - see README.md
resource "google_secret_manager_secret" "something-fastapi_secrets" {
  for_each = toset([
    "secret",
  ])
  secret_id = "something-fastapi-${each.key}"

  labels = {
    purpose = "function-secret"
    type    = "env-var"
  }

  replication {
    automatic = true
  }
}

### Artifact Registry ###

resource "google_artifact_registry_repository" "something-fastapi" {
  location      = "us-central1"
  repository_id = "something-fastapi"
  description   = "Something FastAPI Docker Repo"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_member" "something-fastapi" {
  location   = google_artifact_registry_repository.something-fastapi.location
  repository = google_artifact_registry_repository.something-fastapi.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.something-fastapi.email}"
}