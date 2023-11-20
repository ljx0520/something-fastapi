# Terraform Bootstrap

This is a one-off Terraform script to set up the GCS bucket required to store the Terraform state for other plans.

The state file is not checked in but this script should only be required to run in an entirely new GCP org, at which the
current state file is irrelevant.
