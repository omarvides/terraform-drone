# Drone CI/CD terraform for Digital Ocean instances
This module can be used to create to create drone.io instances on digital ocean droplets, it currently creates only single droplet instances
## Usage example
``` terraform
data "template_file" "env_file_content" {
  template = "${file("files/docker-compose.yaml.tpl")}"

  vars = {
    crt_file_location = "${var.crt_file_location}"
    key_file_location = "${var.key_file_location}"
  }
}


module "clouderx" {
  source                          = "git@github.com:omarvides/terraform-drone.git?ref=1.0.0//digital_ocean"
  domain                          = "example.com"
  server_crt_file_content         = "${file(${var.crt_file_location}})}"
  server_key_file_content         = "${file(${var.key_file_location})}"
  do_token                        = "${var.do_token}"
  ssh_fingerprints                = "${var.ssh_fingerprint}"
  docker_compose_file_destination = "${var.docker_compose_file_destination}"
  env_file_content                = "${data.template_file.env_file_content}"
  docker_compose_file_content     = "${file("files/.env")}"
  subdomain                       = "drone"
  server_crt_and_key_destination  = "${var.keys_destination}"
}

```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| do_token | Your Digital Ocean API token | string | - | yes |
| docker_compose_file_content |  | string | - | yes |
| docker_compose_file_destination |  | string | - | yes |
| domain | Your drone server domain in the form domain.something | string | - | yes |
| env_file_content |  | string | - | yes |
| image | The digital ocean image to use, this module right now only works with centos, specifically centos-7-x64, you can use doctl compute image list-distribution to find out more | string | `centos-7-x64` | no |
| name | The name fo the dropplet that will be ceated, this can be any droplet valid name that you want | string | `drone` | no |
| region | The region where you want to create your drone instance, by default nyc1 | string | `nyc1` | no |
| server_crt_and_key_destination |  | string | - | yes |
| server_crt_file_content |  | string | - | yes |
| server_key_file_content |  | string | - | yes |
| size | The size of the droplet you want to create, by default is set to s-1vcpu-1gb ($5/month) you can use doctl compute size list to find more | string | `s-1vcpu-1gb` | no |
| ssh_fingerprints |  | list | - | yes |
| subdomain |  | string | `drone` | no |

## Outputs

| Name | Description |
|------|-------------|
| disk | The disk size in Gbs |
| id | The new instance id value |
| price_montlhy | The monthly price in dollars ($) of this dropplet |
| public_ip | Droplet's public ip address |
| region | The region where the dropplet was created |
| status | The drone droplet status |
| vcpu | Virtual number of cores of the drone droplet |

