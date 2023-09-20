# backup


## Check the outputs in outputs.tf in the child module (master instance)
```hcl
output "instance_name" {
  value       = google_sql_database_instance.postgres_db_instance.name
  description = "The instance name for the master instance"
}

output "instance_version" {
  value = google_sql_database_instance.postgres_db_instance.database_version
}

output "instance_version" {
  value = google_sql_database_instance.postgres_db_instance.service_account_email_address
}
```

## change this terraform remote state configuration.  

```hcl
data "terraform_remote_state" "master" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket      = "<name_of_the_bucket>" #replace this with your master instance bucket name
    prefix      = "<name_of_the_folder>" #replace this with your master instance bucket prefix
    credentials = "cred.json"
  }
}
```
