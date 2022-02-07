terraform {
  backend "gcs" {
    bucket = "my_terraform_bucket_2"
    prefix = "terraform/state"
  }
}
