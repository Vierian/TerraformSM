resource "google_storage_bucket" "storage" {
  name          = "module-2-bucket-${var.project}"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}