module "Vm" {
  source = "./Modules/Vm"

  name           = var.name
  machine_type   = var.machine_type
  zone           = var.zone
  desired_status = var.desired_status
  network        = var.network
  image          = var.image
  protocol       = var.protocol
  ports          = var.ports
  source_ranges  = var.source_ranges
  target_tags    = var.target_tags
  algorithm      = var.algorithm
  rsa_bits       = var.rsa_bits
}

