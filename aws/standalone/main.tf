/**
* # Drone CI/CD terraform for AWS instances
*/

resource "aws_instance" "drone_standalone" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
    }

    inline = [
      "mkdir -p /etc/ssl",
      "mkdir -p /opt/drone",
    ]
  }

  provisioner "file" {
    content     = "${var.server_crt_file_content}"
    destination = "/etc/ssl/server.crt"
  }

  provisioner "file" {
    content     = "${var.server_key_file_content}"
    destination = "/etc/ssl/server.key"
  }

  provisioner "file" {
    content     = "${var.env_file_content}"
    destination = "/opt/drone/.env"
  }

  provisioner "file" {
    content     = "${var.docker_compose_file_content}"
    destination = "/opt/drone/docker-compose.yaml"
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

data "aws_route53_zone" "default_zone" {
  name         = "${var.route53_zone}"
  private_zone = false
}

resource "aws_route53_record" "subdomain" {
  zone_id = "${data.aws_route53_zone.default_zone.zone_id}"
  name    = "${var.subdomain}.${data.aws_route53_zone.default_zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.drone_standalone.public_ip}"]
}

resource "aws_security_group" "https_access" {
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "https_access" {
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_access" {
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}
