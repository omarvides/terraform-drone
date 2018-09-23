variable "ami_id" {
  description = "The id of the AMI to create the instance"
}

variable "instance_type" {}

variable "server_crt_file_content" {}

variable "server_key_file_content" {}

variable "env_file_content" {}

variable "docker_compose_file_content" {}

variable "drone_domain" {}

variable "route53_zone" {}

variable "subdomain" {}
