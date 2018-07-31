
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| do_token |  | string | - | yes |
| domain | Your drone server domain in the form domain.something | text | - | yes |
| image | The digital ocean image to use, this module right now only works with centos, specifically centos-7-x64, you can use doctl compute image list-distribution to find out more | string | `centos-7-x64` | no |
| name | The name fo the dropplet that will be ceated, this can be any droplet valid name that you want | string | `drone` | no |
| region | The region where you want to create your drone instance, by default nyc1 | string | `nyc1` | no |
| size | The size of the droplet you want to create, by default is set to s-1vcpu-1gb ($5/month) you can use doctl compute size list to find more | string | `s-1vcpu-1gb` | no |
| ssh_fingerprints |  | list | - | yes |

