resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.storage.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "project" {
  project = var.project
  role    = "roles/pubsub.admin"
  member  = "serviceAccount:${google_service_account.default.email}"
}