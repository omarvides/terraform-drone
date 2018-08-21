# Terraform drone

This terraform repository can create Drone.io CI/CD Tool at many cloud providers, it currently can create Drone servers at

* DigitalOcean


## Digital Ocean

At DigitalOcean it uses the following default configurations


| Property | Value |
|----|-----:|
| Image | centos-7-x64 |
| Droplet name | drone |
| Region | nyc1 |
| Droplet size | s-1vcpu-1gb |


## Usage 

Here [README.md](./digital_ocean/README.md) you can find out what variables this module requires when imported as a source inside other terraform module

Please stick to a tag, to guarantee the proper functioning of your code


## Changelog

* NEXT VERSION: Will update DigitalOcean Repository to have fixed directories for crt, key and docker-compose files
* VERSION 0.1: Digital ocean standalone version supported (this means only one droplet with one server and one worker inside)


## Known issues

* DigitalOcean provider for terraform has a known issue where a domain cannot be created with an IP address, this is a problem for this module and any other because there is no way to only register a domain using terraform without having an already existing Droplet, this means that you cannot have a module that only creates a domain and other modules that create the VMs after the domain is created, it requires always to have a VM created to register a domain, so you will be able to use this module to create one and only one server in digital ocean of drone.io, if you try to use this module to create a second drone.io module with an already registered domain terraform will create your server but will fail to register you A record, this is out of my hands until this issue is resolved [Make ip_address optional for digitalocean_domain (as it is in DigitalOcean’s API)](https://github.com/terraform-providers/terraform-provider-digitalocean/issues/112)
