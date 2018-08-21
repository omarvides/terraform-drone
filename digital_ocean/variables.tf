variable "do_token" {
  description = "Your Digital Ocean API token"
  type        = "string"
}

variable "image" {
  description = "The digital ocean image to use, this module right now only works with centos, specifically centos-7-x64, you can use doctl compute image list-distribution to find out more"
  default     = "centos-7-x64"
}

variable "name" {
  description = "The name fo the dropplet that will be ceated, this can be any droplet valid name that you want"
}

variable "region" {
  description = "The region where you want to create your drone instance, by default nyc1"
  default     = "nyc1"
}

variable "size" {
  description = "The size of the droplet you want to create, by default is set to s-1vcpu-1gb ($5/month) you can use doctl compute size list to find more"
  default     = "s-1vcpu-1gb"
}

variable "ssh_fingerprints" {
  type = "list"
}

variable "domain" {
  description = "Your drone server domain in the form domain.something"
  type        = "string"
}


variable "server_crt_file_content" {
  description = ""
  type        = "string"
}

variable "server_key_file_content" {
  description = ""
  type        = "string"
}

variable "env_file_content" {
  description = ""
  type        = "string"
}

variable "docker_compose_file_content" {
  description = ""
  type        = "string"
}

variable "subdomain" {
  description = ""
  default     = "drone"
}
