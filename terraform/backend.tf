terraform {
  backend "gcs" {
    bucket = "my_terraform_bucket_3_ubuntu"
    prefix = "terraform/state"
  }
}
