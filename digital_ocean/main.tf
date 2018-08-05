/**
* # Drone CI/CD terraform for Digital Ocean instances
* This module can be used to create to create drone.io instances on digital ocean droplets, it currently creates only single droplet instances
* ## Usage example
* ``` terraform
* data "template_file" "env_file_content" {
*   template = "${file("files/docker-compose.yaml.tpl")}"
* 
*   vars = {
*     crt_file_location = "${var.crt_file_location}"
*     key_file_location = "${var.key_file_location}"
*   }
* }
* 
* 
* module "clouderx" {
*   source                          = "../drone-do/digital_ocean"
*   domain                          = "clouderx.com"
*   server_crt_file_content         = "${file(${var.crt_file_location}})}"
*   server_key_file_content         = "${file(${var.key_file_location})}"
*   do_token                        = "${var.do_token}"
*   ssh_fingerprints                = "${var.ssh_fingerprint}"
*   docker_compose_file_destination = "${var.docker_compose_file_destination}"
*   env_file_content                = "${data.template_file.env_file_content}"
*   docker_compose_file_content     = "${file("files/.env")}"
*   subdomain                       = "drone"
*   server_crt_and_key_destination  = "${var.keys_destination}"
* }

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

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
    }

    inline = [
      "mkdir -p ${var.server_crt_and_key_destination}",
      "mkdir -p ${var.docker_compose_file_destination}",
    ]
  }

  provisioner "file" {
    content     = "${var.server_crt_file_content}"
    destination = "${var.server_crt_and_key_destination}/server.crt"
  }

  provisioner "file" {
    content     = "${var.server_key_file_content}"
    destination = "${var.server_crt_and_key_destination}/server.key"
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
