resource "google_storage_bucket" "project" {
  name          = "module-1-bucket-${var.project}"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}