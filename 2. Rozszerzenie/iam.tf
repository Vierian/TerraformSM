resource "google_project_iam_member" "project" {
  project = var.project
  role    = "roles/pubsub.admin"
  member  = "serviceAccount:${google_service_account.default.email}"
  depends_on = [
    google_project_service.services
  ]
}

resource "google_service_account" "default" {
  account_id   = "serviceaccountid"
  display_name = "Service Account"
}