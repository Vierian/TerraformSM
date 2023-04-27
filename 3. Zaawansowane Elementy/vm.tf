resource "google_service_account" "default" {
  account_id   = "serviceaccountid"
  display_name = "Service Account"
}


resource "google_compute_instance" "modulevm" {
  count        = length(var.subnets)
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
    subnetwork = module.subnets.subnets[var.subnets[count.index].subnet_name].id
    access_config {
      nat_ip = google_compute_address.static[count.index].address
    }
  }
  metadata_startup_script = "echo hi > /test_${count.index}.txt && gsutil cp /*.txt gs://${google_storage_bucket.storage.name}"


  provisioner "remote-exec" {
    inline = [
      "env",
      "sudo apt update && sudo apt -y install apache2"
    ]
    connection {
      host        = self.network_interface[0].access_config[0].nat_ip #google_compute_address.static[count.index].address
      type        = "ssh"
      user        = var.user
      timeout     = "500s"
      private_key = tls_private_key.pk.private_key_pem #"${file("./keys/private")}"
    }
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope terraform initand permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
  depends_on = [
    google_storage_bucket_iam_member.member,
    module.subnets
  ]

  metadata = {
    ssh-keys = "${var.user}:${tls_private_key.pk.public_key_openssh}" #"${var.user}:${file("./keys/public")}"
  }
}

resource "google_compute_address" "static" {
  count      = length(var.subnets)
  name       = "vm-public-address-${count.index}"
  project    = var.project
  region     = var.region
  depends_on = [google_compute_firewall.default]
}