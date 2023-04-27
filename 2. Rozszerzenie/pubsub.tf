module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 5.0"
  topic      = "tf-topic"
  project_id = var.project
  pull_subscriptions = [
    {
      name                         = "pull"                                               // required
      ack_deadline_seconds         = 20                                                   // optional
      max_delivery_attempts        = 5                                                    // optional
    }
  ]
  depends_on = [
    google_service_account.default
    
  ]
}

resource "google_compute_instance" "pubsub" {
  for_each = var.pubsub
  name         = each.value.name
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
    network = google_compute_network.vpc_network.id
    subnetwork = each.value.sender ? google_compute_subnetwork.sub[0].id : google_compute_subnetwork.sub[1].id
  }
  
  metadata_startup_script = each.value.sender ? "gcloud pubsub topics publish ${module.pubsub.topic} --message=message1" : "sleep 10 && echo ${module.pubsub.subscription_names[0]} > /get-message-list && gcloud pubsub subscriptions pull ${module.pubsub.subscription_names[0]} > /get-message.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
  depends_on = [
    module.pubsub
  ]
}