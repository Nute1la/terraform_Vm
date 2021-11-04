terraform {
  backend "gcs" {
    bucket  = "terraform-mybucket"
    prefix  = "terraform/state"
  }
}
