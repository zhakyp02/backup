resource "google_storage_bucket" "exports" {
  name     = "postgresql-exports-backups-tester"
  location = "us-central1"
  # TODO: don't use force_destroy for production this is just required for testing
  force_destroy = false
  project       = var.project_id

}
