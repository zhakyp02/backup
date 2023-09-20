# backup


## check this outputs in outputs.tf in child module (master instance)
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
