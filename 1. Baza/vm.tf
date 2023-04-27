resource "google_service_account" "default" {
  account_id   = "serviceaccountid"
  display_name = "Service Account"
}

resource "google_compute_instance" "default2" {
  count        = 2
  name         = "default-instance-nr-${count.index}"
  machine_type = "e2-micro" #free tier eligable
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }


  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.sub[count.index].id
  }

  metadata_startup_script = "echo hi > /test_${count.index}.txt && gsutil cp /*.txt gs://${google_storage_bucket.project.name}"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
  depends_on = [
    google_storage_bucket_iam_member.member
  ]
}