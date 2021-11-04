resource "google_compute_instance" "kotik_Vm" {
  name           = "kotik_Vm"
  machine_type   = "e2-small"
  zone           = "us-central1-a"
  desired_status = "RUNNING"

  network_interface {
    network = "default"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "tls_private_key" "example" {
  algorithm   = "RSA"
  rsa_bits = "2048"
}

