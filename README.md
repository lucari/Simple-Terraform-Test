# Simple Terraform Test

This simple tests creates a new VPC network, a subnet and a number of firewall rules.

## Key files

- [providers.tf](providers.tf) - contains the provider information, project, region and zone info. Also contains the access credentials.
- [backend.tf](backend.tf) - contains the details of the GCP Bucket to hold the terraform state information
- [compute.tf](compute.tf) - contains the buidl details for the compute instance
- [network.tf](network.tf) - contains the build details for the VPC, subnet and firewall rules
- [loadbalancer.tf](loadbalancer.tf) - contains the build details for the HTTP Load Balancer
- [variables.tf](variables.tf) - contains the variable definitions that the build uses along with any defaults.
- [terraform.tfvars](terraform.tfvars) - contains the actual parameters to use for the build
- [.gitignore](.gitignore) - defines the files that are created by the build that don't need to be added into the repository.


## Steps to build

```
- terraform init
- terraform validate
- terraform plan
- terraform apply
```
