data "google_project" "project_data" {
}

output "project_number_data" {
  value = data.google_project.project.number
}

#https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project