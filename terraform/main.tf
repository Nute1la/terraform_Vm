module "Vm" {
  source = "./Modules/Vm"
  count  = 3

  name           = "${var.name}-${count.index}"
  machine_type   = var.machine_type
  zone           = var.zone
  desired_status = var.desired_status
  network        = var.network
  image          = var.image
  protocol       = var.protocol
  ports          = var.ports
  source_ranges  = var.source_ranges
  target_tags    = var.target_tags
  tls_private_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("Modules/Vm/templates/inventory.tmpl",
    {
      ansible_username        = module.Vm.*.username,
      ansible_ip              = module.Vm.*.ip,
      ansible_ssh_common_args = "'-o StrictHostKeyChecking=no'",
      ansible_connection      = "ssh"
    }
  )
  filename = "../Files/inventory"
}

resource "local_file" "private_key" {
  content = templatefile("Modules/Vm/templates/private_key.tmpl",
    {
      ssh_private_key = tls_private_key.example.private_key_pem
    }
  )
  file_permission = 0400
  filename = "../Files/private_key"
}


resource "tls_private_key" "example" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}


#output "test" {
#  value = module.Vm.*.ip
#}