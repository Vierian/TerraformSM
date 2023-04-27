data "google_project" "project" {
  project_id = var.project
}

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project                    = var.project
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
  depends_on = [data.google_project.project]
}