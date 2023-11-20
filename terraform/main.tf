terraform {
  backend "gcs" {}

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "google_project" "project" {}

# Enable APIs

resource "google_project_service" "services" {
  for_each = toset([
    "artifactregistry.googleapis.com",
    "batch.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudtasks.googleapis.com",
    "drive.googleapis.com",
    "firestore.googleapis.com",
    "iamcredentials.googleapis.com", # for workload identity
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "sts.googleapis.com", # for workload identity
    "workflows.googleapis.com",
  ])
  service = each.key
}