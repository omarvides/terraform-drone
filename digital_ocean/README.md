# Drone CI/CD terraform for Digital Ocean instances
This module can be used to create to create drone.io instances on digital ocean droplets, it currently creates only single droplet instances
## Usage example
``` terraform
 module "my-drone-server" {
  source = "git@github.com:omarvides/terraform-drone.git?ref=1.0.0//digital_ocean"
  ssh_fingerprints=["00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"]
  do_token = "my-do-token"
  domain = "mysuperdomainsomethingunique.com"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| do_token | Your Digital Ocean API token | string | - | yes |
| domain | Your drone server domain in the form domain.something | string | - | yes |
| image | The digital ocean image to use, this module right now only works with centos, specifically centos-7-x64, you can use doctl compute image list-distribution to find out more | string | `centos-7-x64` | no |
| name | The name fo the dropplet that will be ceated, this can be any droplet valid name that you want | string | `drone` | no |
| region | The region where you want to create your drone instance, by default nyc1 | string | `nyc1` | no |
| size | The size of the droplet you want to create, by default is set to s-1vcpu-1gb ($5/month) you can use doctl compute size list to find more | string | `s-1vcpu-1gb` | no |
| ssh_fingerprints |  | list | - | yes |

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

