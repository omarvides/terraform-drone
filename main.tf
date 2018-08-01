provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "drone_droplet" {
  image    = "${var.image}"
  name     = "${var.name}"
  region   = "${var.region}"
  size     = "${var.size}"
  ssh_keys = "${var.ssh_fingerprints}"

  provisioner "file" {
    source      = "certs/server.crt"
    destination = "/opt/server.crt"
  }

  provisioner "file" {
    source      = "certs/server.key"
    destination = "/opt/server.key"
  }

  provisioner "file" {
    source      = "./files/.env"
    destination = "/opt/.env"
  }

  provisioner "file" {
    source      = "./files/docker-compose.yaml"
    destination = "/opt/docker-compose.yaml"
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
  name   = "drone"
  domain = "${digitalocean_domain.current.name}"
  type   = "A"
  value  = "${digitalocean_domain.current.ip_address}"
}
