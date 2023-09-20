terraform {
  required_version = ">= 0.13"
  backend "gcs" {
    bucket      = "terraformtfd"
    prefix      = "terraform/bucket.tfstate"
    credentials = "cred.json"
  }
}
