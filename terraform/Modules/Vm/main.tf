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
    ssh-keys = "${random_string.username.result}:${tls_private_key.example.public_key_openssh}"
  }
}


resource "google_compute_address" "static" {
  name = "${var.name}-ipv4-address"
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
  filename        = "../Files/private_key"
  file_permission = 400
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl",
    {
      ansible_username        = "${random_string.username.result}",
      ansible_ip              = google_compute_address.static.address,
      ansible_instance_name   = var.name,
      ansible_ssh_common_args = "'-o StrictHostKeyChecking=no'",
      ansible_connection      = "ssh"
    }
  )
  filename = "../Files/inventory"
}

resource "random_string" "username" {
  length  = 6
  special = false
}
