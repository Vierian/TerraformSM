
resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.project.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.default.email}"
  depends_on = [
    google_project_service.services
  ]
}