/**
* # Drone CI/CD terraform for Digital Ocean instances
* This module can be used to create to create drone.io instances on digital ocean droplets, it currently creates only single droplet instances
* ## Usage example
* ``` terraform
*  module "my-drone-server" {
*   source = "git@github.com:omarvides/terraform-drone.git?ref=1.0.0//digital_ocean"
*   ssh_fingerprints=["00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"]
*   do_token = "my-do-token"
*   domain = "mysuperdomainsomethingunique.com"
*}
* ```
*/

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "drone_droplet" {
  image    = "${var.image}"
  name     = "${var.name}"
  region   = "${var.region}"
  size     = "${var.size}"
  ssh_keys = "${var.ssh_fingerprints}"

  provisioner "remot-exec" {
    connection {
      type = "ssh"
      user = "root"
    }

    scripts = [
      "mkdir -p ${var.server_crt_and_key_destination}",
      "mkdir -p ${var.docker_compose_file_content}",
    ]
  }

  provisioner "file" {
    content     = "${var.server_crt_file_content}"
    destination = "${var.server_crt_and_key_destination}"
  }

  provisioner "file" {
    content     = "${var.server_key_file_content}"
    destination = "${var.server_crt_and_key_destination}"
  }

  provisioner "file" {
    content     = "${var.env_file_content}"
    destination = "${var.docker_compose_file_destination}/.env"
  }

  provisioner "file" {
    content     = "${var.docker_compose_file_content}"
    destination = "${var.docker_compose_file_destination}/docker-compose.yaml"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
    }

    scripts = [
      "./scripts/initscript.sh",
    ]
  }
}

resource "digitalocean_domain" "current" {
  name       = "${var.domain}"
  ip_address = "${digitalocean_droplet.drone_droplet.ipv4_address}"
}

resource "digitalocean_record" "drone" {
  name   = "${var.subdomain}"
  domain = "${digitalocean_domain.current.name}"
  type   = "A"
  value  = "${digitalocean_domain.current.ip_address}"
}
