terraform {
  backend "gcs" {
    bucket  = "tf-backend-bucket-ljedras"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = var.project
  region      = var.region
}
