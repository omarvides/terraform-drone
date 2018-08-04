# Terraform drone (Unstable)

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

Here [USAGE.md](./digital_ocean/README.md) you can find out what variables this module requires when imported as a source inside other terraform module