terraform {
  backend "local" {}
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "terraform_state" {
  name     = "org-tfstate-${random_id.bucket_prefix.hex}"
  project  = var.project_id
  location = "US"

  public_access_prevention = "enforced"
  force_destroy            = true

  versioning {
    enabled = true
  }
}