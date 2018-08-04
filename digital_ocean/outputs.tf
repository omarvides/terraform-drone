output "id" {
  description = "The new instance id value"
  value       = "${digitalocean_droplet.drone_droplet.id}"
}

output "status" {
  description = "The drone droplet status"
  value       = "${digitalocean_droplet.drone_droplet.status}"
}

output "public_ip" {
  description = "Droplet's public ip address"
  value       = "${digitalocean_droplet.drone_droplet.ipv4_address}"
}

output "vcpu" {
  description = "Virtual number of cores of the drone droplet"
  value       = "${digitalocean_droplet.drone_droplet.vcpus}"
}

output "disk" {
  description = "The disk size in Gbs"
  value       = "${digitalocean_droplet.drone_droplet.disk}"
}

output "region" {
  description = "The region where the dropplet was created"
  value       = "${digitalocean_droplet.drone_droplet.region}"
}

output "price_montlhy" {
  description = "The monthly price in dollars ($) of this dropplet"
  value       = "${digitalocean_droplet.drone_droplet.price_monthly}"
}
