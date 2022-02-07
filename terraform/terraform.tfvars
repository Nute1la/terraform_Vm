name           = "my-server"
machine_type   = "e2-small"
zone           = "us-central1-a"
desired_status = "RUNNING"
network        = "default"
image          = "debian-cloud/debian-9"
protocol       = "tcp"
ports          = ["80", "22", "443"]
source_ranges  = ["0.0.0.0/0"]
target_tags    = ["http-server"]
algorithm      = "RSA"
rsa_bits       = "2048"

