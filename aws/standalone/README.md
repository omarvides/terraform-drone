# Drone CI/CD terraform for AWS instances


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami_id |  | string | `` | no |
| docker_compose_file_content |  | string | `` | no |
| docker_compose_file_destination |  | string | `` | no |
| drone_domain |  | string | `` | no |
| env_file_content |  | string | `` | no |
| instance_type |  | string | `` | no |
| route53_zone |  | string | `clouderx.net.` | no |
| server_crt_and_key_destination |  | string | `` | no |
| server_crt_file_content |  | string | `` | no |
| server_key_file_content |  | string | `` | no |
| subdomain |  | string | `drone` | no |

