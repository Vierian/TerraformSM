output "project_number" {
  value = data.google_project.project.number
}

output "ip_address" {
  value = google_compute_instance.modulevm[*].network_interface[0].access_config[0].nat_ip
}