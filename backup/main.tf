
data "terraform_remote_state" "master" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket      = "<name_of_the_bucket>"
    prefix      = "<name_of_the_folder>"
    credentials = "cred.json"
  }
}

resource "google_storage_bucket" "exports" {
  name     = "postgresql-exports-backup"
  location = "us-central1"
  # TODO: don't use force_destroy for production this is just required for testing
  force_destroy = false
  project       = var.project_id

}



module "cloudsql_postgres_backup_test" {
  source = "git::https://gitlab.com/keybank/dbl00/modules/cloudsql-backup-module.git?ref=0.1.0"
  #   source = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/backup?ref=master"

  project_id                    = var.project_id
  export_uri                    = google_storage_bucket.exports.url
  sql_instance                  = data.terraform_remote_state.master.outputs.instance_name
  instance_version              = data.terraform_remote_state.master.instance_version
  service_account_email_address = data.terraform_remote_state.master.instance_service_account_email_address
  backup_retention_time         = "0 0 1 10 *"
  backup_schedule               = "0 0 1 10 *"
}
