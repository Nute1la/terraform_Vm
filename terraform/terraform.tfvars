name           = "my-server"
machine_type   = "e2-small"
zone           = "us-central1-a"
desired_status = "RUNNING"
network        = "default"
image          = "ubuntu-os-cloud/ubuntu-1804-lts"
protocol       = "tcp"
ports          = ["80", "22", "443"]
source_ranges  = ["0.0.0.0/0"]
target_tags    = ["http-server"]
algorithm      = "RSA"
rsa_bits       = "2048"


