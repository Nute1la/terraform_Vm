resource "google_compute_instance" "my_server" {
  name           = var.name
  machine_type   = var.machine_type
  zone           = var.zone
  desired_status = var.desired_status

  network_interface {
    network = var.network
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata = {
    ssh-keys = "${random_string.username.result}:${var.tls_private_key}"
  }

  tags = var.target_tags
}

resource "google_compute_firewall" "http-server" {
  name    = "${var.name}-allow-http"
  network = var.network


  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}

resource "google_compute_address" "static" {
  name = "${var.name}-address"
}

resource "random_string" "username" {
  length  = 6
  special = false
}

