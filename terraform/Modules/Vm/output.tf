output "ip" {
value = google_compute_address.static.address
}

output "username" {
value = random_string.username.result
}
