terraform {
  backend "gcs" {
    bucket = "my_bucket_terraform"
    prefix = "terraform/state"
  }
}
