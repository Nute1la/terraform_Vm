resource "google_compute_instance" "kotik_Vm" {
  name           = var.name
  machine_type   = var.machine_type
  zone           = var.zone
  desired_status = var.desired_status

  network_interface {
    network = var.network
  }

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata = {
    ssh-keys = "unit:${tls_private_key.example.public_key_pem}"
  }
}

resource "google_compute_firewall" "http-server" {
  name    = "${var.name}allow-http"
  network = var.network

  allow {
    protocol = var.protocol
    ports    = var.ports
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}

resource "tls_private_key" "example" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "local_file" "key" {
  content = templatefile("${path.module}/templates/private_key.tmpl",
    {
    ssh_private_key = tls_private_key.example.private_key_pem
    }
  )
  filename = "private_key"
}
