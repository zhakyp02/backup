# backup

# First, you can create a cloud storage bucket within a new repository

## add the Terraform remote state configuration to the root module and make the following changes: update the export URI, backup retention time, and backup schedule
```hcl
data "terraform_remote_state" "master" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket      = "terraformtfd"
    prefix      = "terraform/bucket.tfstate"
    credentials = "cred.json"
  }
}


 module "cloudsql_postgres_backup_test" {
   source = "git::https://gitlab.com/module.git?ref=0.1.0"
   project_id                 = var.project_id
   export_uri                 = data.terraform_remote_state.master.outputs.export_uri
   sql_instance               = module.cloudsql_postgres_sync_test.instance_name
   instance_version           = module.cloudsql_postgres_sync_test.instance_version
   service_account_email_address = module.cloudsql_postgres_sync_test.instance_service_account_email_address
   backup_retention_time      = "0 0 1 10 *"
   backup_schedule            = "0 2 1 10 *"
 }

```



