resource "aws_instance" "drone_standalone" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

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
      "${path.module}/scripts/initscript.sh",
    ]
  }
}

resource "aws_route53_record" "github" {
  name = ""
  type = ""
  zone_id = ""
}

resource "aws_security_group" "https_access" {}

resource "aws_security_group" "ssh_access" {}
