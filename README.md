# Networking Terraform Module for AWS - terraform-aws-vpc #

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.13 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Inputs

| Name                                             | Description                                                        | Type   | Default | Required |
| ------------------------------------------------ | ------------------------------------------------------------------ | ------ | ------- | :------: |
| availability\_zones                              | List of availability zones to be used by subnets                   | `list` | n/a     |   yes    |
| name\_prefix                                     | Name prefix for resources on AWS                                   | `any`  | n/a     |   yes    |
| private\_subnets\_cidrs\_per\_availability\_zone | List of CIDRs to use on each availability zone for private subnets | `list` | n/a     |   yes    |
| public\_subnets\_cidrs\_per\_availability\_zone  | List of CIDRs to use on each availability zone for public subnets  | `list` | n/a     |   yes    |
| single\_nat                                      | enable single NAT Gateway                                          | `bool` | `false` |    no    |
| vpc\_cidr\_block                                 | AWS VPC CIDR Block                                                 | `any`  | n/a     |   yes    |

## Outputs

| Name                               | Description                                                                                            |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------ |
| availability\_zones                | List of availability zones used by subnets                                                             |
| internet\_gateway\_id              | ID of the generated Internet Gateway                                                                   |
| nat\_gw\_ids                       | List with the IDs of the NAT Gateways created on public subnets to provide internet to private subnets |
| private\_subnets\_ids              | List with the Private Subnets IDs                                                                      |
| private\_subnets\_route\_table\_id | ID of the Route Table used on Private networks                                                         |
| public\_subnets\_ids               | List with the Public Subnets IDs                                                                       |
| public\_subnets\_route\_table\_id  | ID of the Route Tables used on Public networks                                                         |
| vpc\_cidr\_block                   | The CIDR block of the VPC                                                                              |
| vpc\_id                            | The ID of the VPC                                                                                      |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Demo

```
sivakumarvunnam@NBCPHJYY2:~/workspace$ git clone https://github.com/sivakumarvunnam/terraform-aws-vpc.git
sivakumarvunnam@NBCPHJYY2:~/workspace$ cd terraform-aws-vpc
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc$ ls
README.md  example  main.tf  varibles.tf  version.tf
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc$ cd example/dev/
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc/example/dev$ ls
main.tf
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc/example/dev$ terraform init
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v3.47.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc/example/dev$ terraform fmt
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc/example/dev$ terraform validate
Success! The configuration is valid.

sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc/example/dev$ terraform plan -out plan_out

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.aws-base-network.aws_eip.nat_eip[0] will be created
  + resource "aws_eip" "nat_eip" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "Name" = "dev-nat-eip-us-east-1a"
        }
      + tags_all             = {
          + "Name" = "dev-nat-eip-us-east-1a"
        }
      + vpc                  = true
    }

  # module.aws-base-network.aws_internet_gateway.internet_gw will be created
  + resource "aws_internet_gateway" "internet_gw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "dev-internet-gw"
        }
      + tags_all = {
          + "Name" = "dev-internet-gw"
        }
      + vpc_id   = (known after apply)
    }

  # module.aws-base-network.aws_nat_gateway.nat_gw[0] will be created
  + resource "aws_nat_gateway" "nat_gw" {
      + allocation_id        = (known after apply)
      + connectivity_type    = "public"
      + id                   = (known after apply)
      + network_interface_id = (known after apply)
      + private_ip           = (known after apply)
      + public_ip            = (known after apply)
      + subnet_id            = (known after apply)
      + tags                 = {
          + "Name" = "dev-nat-gw-us-east-1a"
        }
      + tags_all             = {
          + "Name" = "dev-nat-gw-us-east-1a"
        }
    }

  # module.aws-base-network.aws_route.private_internet_route[0] will be created
  + resource "aws_route" "private_internet_route" {
      + destination_cidr_block = "0.0.0.0/0"
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + nat_gateway_id         = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # module.aws-base-network.aws_route.private_internet_route[1] will be created
  + resource "aws_route" "private_internet_route" {
      + destination_cidr_block = "0.0.0.0/0"
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + nat_gateway_id         = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # module.aws-base-network.aws_route.public_internet_route[0] will be created
  + resource "aws_route" "public_internet_route" {
      + destination_cidr_block = "0.0.0.0/0"
      + gateway_id             = (known after apply)
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # module.aws-base-network.aws_route.public_internet_route[1] will be created
  + resource "aws_route" "public_internet_route" {
      + destination_cidr_block = "0.0.0.0/0"
      + gateway_id             = (known after apply)
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # module.aws-base-network.aws_route_table.private_subnets_route_table[0] will be created
  + resource "aws_route_table" "private_subnets_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Name" = "dev-private-rt-us-east-1a"
        }
      + tags_all         = {
          + "Name" = "dev-private-rt-us-east-1a"
        }
      + vpc_id           = (known after apply)
    }

  # module.aws-base-network.aws_route_table.private_subnets_route_table[1] will be created
  + resource "aws_route_table" "private_subnets_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Name" = "dev-private-rt-us-east-1b"
        }
      + tags_all         = {
          + "Name" = "dev-private-rt-us-east-1b"
        }
      + vpc_id           = (known after apply)
    }

  # module.aws-base-network.aws_route_table.public_subnets_route_table[0] will be created
  + resource "aws_route_table" "public_subnets_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Name" = "dev-public-rt-us-east-1a"
        }
      + tags_all         = {
          + "Name" = "dev-public-rt-us-east-1a"
        }
      + vpc_id           = (known after apply)
    }

  # module.aws-base-network.aws_route_table.public_subnets_route_table[1] will be created
  + resource "aws_route_table" "public_subnets_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Name" = "dev-public-rt-us-east-1b"
        }
      + tags_all         = {
          + "Name" = "dev-public-rt-us-east-1b"
        }
      + vpc_id           = (known after apply)
    }

  # module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[0] will be created
  + resource "aws_route_table_association" "private_internet_route_table_associations" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[1] will be created
  + resource "aws_route_table_association" "private_internet_route_table_associations" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[0] will be created
  + resource "aws_route_table_association" "public_internet_route_table_associations" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[1] will be created
  + resource "aws_route_table_association" "public_internet_route_table_associations" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.aws-base-network.aws_subnet.private_subnets[0] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "192.168.128.0/19"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "dev-private-net-us-east-1a"
        }
      + tags_all                        = {
          + "Name" = "dev-private-net-us-east-1a"
        }
      + vpc_id                          = (known after apply)
    }

  # module.aws-base-network.aws_subnet.private_subnets[1] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "192.168.160.0/19"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "dev-private-net-us-east-1b"
        }
      + tags_all                        = {
          + "Name" = "dev-private-net-us-east-1b"
        }
      + vpc_id                          = (known after apply)
    }

  # module.aws-base-network.aws_subnet.public_subnets[0] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "192.168.0.0/19"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "dev-public-net-us-east-1a"
        }
      + tags_all                        = {
          + "Name" = "dev-public-net-us-east-1a"
        }
      + vpc_id                          = (known after apply)
    }

  # module.aws-base-network.aws_subnet.public_subnets[1] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "192.168.32.0/19"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "dev-public-net-us-east-1b"
        }
      + tags_all                        = {
          + "Name" = "dev-public-net-us-east-1b"
        }
      + vpc_id                          = (known after apply)
    }

  # module.aws-base-network.aws_vpc.vpc will be created
  + resource "aws_vpc" "vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "192.168.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "dev-vpc"
        }
      + tags_all                         = {
          + "Name" = "dev-vpc"
        }
    }

Plan: 20 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: plan_out

To perform exactly these actions, run the following command to apply:
    terraform apply "plan_out"
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc/example/dev$ terraform apply "plan_out"
module.aws-base-network.aws_eip.nat_eip[0]: Creating...
module.aws-base-network.aws_vpc.vpc: Creating...
module.aws-base-network.aws_eip.nat_eip[0]: Creation complete after 1s [id=eipalloc-0592d600e74bfc740]
module.aws-base-network.aws_vpc.vpc: Still creating... [10s elapsed]
module.aws-base-network.aws_vpc.vpc: Creation complete after 15s [id=vpc-004befea10bbb3dac]
module.aws-base-network.aws_subnet.public_subnets[1]: Creating...
module.aws-base-network.aws_route_table.public_subnets_route_table[0]: Creating...
module.aws-base-network.aws_internet_gateway.internet_gw: Creating...
module.aws-base-network.aws_route_table.public_subnets_route_table[1]: Creating...
module.aws-base-network.aws_subnet.private_subnets[1]: Creating...
module.aws-base-network.aws_subnet.public_subnets[0]: Creating...
module.aws-base-network.aws_route_table.private_subnets_route_table[0]: Creating...
module.aws-base-network.aws_subnet.private_subnets[0]: Creating...
module.aws-base-network.aws_route_table.private_subnets_route_table[1]: Creating...
module.aws-base-network.aws_route_table.private_subnets_route_table[0]: Creation complete after 1s [id=rtb-0c27ed5fe2ca3b9f0]
module.aws-base-network.aws_route_table.private_subnets_route_table[1]: Creation complete after 1s [id=rtb-0e847cb6edba2f689]
module.aws-base-network.aws_route_table.public_subnets_route_table[0]: Creation complete after 1s [id=rtb-09ef5f36565c48f0e]
module.aws-base-network.aws_route_table.public_subnets_route_table[1]: Creation complete after 1s [id=rtb-0d07bd9a5b4f4b0eb]
module.aws-base-network.aws_subnet.private_subnets[0]: Creation complete after 1s [id=subnet-07fad8bbc6a36c7d2]
module.aws-base-network.aws_subnet.private_subnets[1]: Creation complete after 1s [id=subnet-0501c55da8ff10ddf]
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[0]: Creating...
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[1]: Creating...
module.aws-base-network.aws_internet_gateway.internet_gw: Creation complete after 1s [id=igw-0462f3e8568d71a8c]
module.aws-base-network.aws_route.public_internet_route[1]: Creating...
module.aws-base-network.aws_route.public_internet_route[0]: Creating...
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[1]: Creation complete after 1s [id=rtbassoc-01bf3ede0ead5fb23]
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[0]: Creation complete after 1s [id=rtbassoc-078826123f715261f]
module.aws-base-network.aws_route.public_internet_route[0]: Creation complete after 1s [id=r-rtb-09ef5f36565c48f0e1080289494]
module.aws-base-network.aws_route.public_internet_route[1]: Creation complete after 2s [id=r-rtb-0d07bd9a5b4f4b0eb1080289494]
module.aws-base-network.aws_subnet.public_subnets[1]: Still creating... [10s elapsed]
module.aws-base-network.aws_subnet.public_subnets[0]: Still creating... [10s elapsed]
module.aws-base-network.aws_subnet.public_subnets[1]: Creation complete after 12s [id=subnet-0ce192c925484c355]
module.aws-base-network.aws_subnet.public_subnets[0]: Creation complete after 12s [id=subnet-06ba39c6fc5ecfa13]
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[0]: Creating...
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[1]: Creating...
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Creating...
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[0]: Creation complete after 1s [id=rtbassoc-0ef51a830c8deabdd]
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[1]: Creation complete after 1s [id=rtbassoc-062bb45d12c8fe617]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [10s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [20s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [30s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [40s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [50s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [1m0s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [1m10s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still creating... [1m20s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Creation complete after 1m28s [id=nat-0815b28b77fe851e7]
module.aws-base-network.aws_route.private_internet_route[1]: Creating...
module.aws-base-network.aws_route.private_internet_route[0]: Creating...
module.aws-base-network.aws_route.private_internet_route[0]: Creation complete after 2s [id=r-rtb-0c27ed5fe2ca3b9f01080289494]
module.aws-base-network.aws_route.private_internet_route[1]: Creation complete after 2s [id=r-rtb-0e847cb6edba2f6891080289494]

Apply complete! Resources: 20 added, 0 changed, 0 destroyed.
sivakumarvunnam@NBCPHJYY2:~/workspace/terraform-aws-vpc/example/dev$ terraform destroy
module.aws-base-network.aws_vpc.vpc: Refreshing state... [id=vpc-004befea10bbb3dac]
module.aws-base-network.aws_eip.nat_eip[0]: Refreshing state... [id=eipalloc-0592d600e74bfc740]
module.aws-base-network.aws_subnet.private_subnets[1]: Refreshing state... [id=subnet-0501c55da8ff10ddf]
module.aws-base-network.aws_subnet.private_subnets[0]: Refreshing state... [id=subnet-07fad8bbc6a36c7d2]
module.aws-base-network.aws_subnet.public_subnets[1]: Refreshing state... [id=subnet-0ce192c925484c355]
module.aws-base-network.aws_internet_gateway.internet_gw: Refreshing state... [id=igw-0462f3e8568d71a8c]
module.aws-base-network.aws_route_table.public_subnets_route_table[1]: Refreshing state... [id=rtb-0d07bd9a5b4f4b0eb]
module.aws-base-network.aws_subnet.public_subnets[0]: Refreshing state... [id=subnet-06ba39c6fc5ecfa13]
module.aws-base-network.aws_route_table.public_subnets_route_table[0]: Refreshing state... [id=rtb-09ef5f36565c48f0e]
module.aws-base-network.aws_route_table.private_subnets_route_table[0]: Refreshing state... [id=rtb-0c27ed5fe2ca3b9f0]
module.aws-base-network.aws_route_table.private_subnets_route_table[1]: Refreshing state... [id=rtb-0e847cb6edba2f689]
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[0]: Refreshing state... [id=rtbassoc-0ef51a830c8deabdd]
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[1]: Refreshing state... [id=rtbassoc-062bb45d12c8fe617]
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[1]: Refreshing state... [id=rtbassoc-01bf3ede0ead5fb23]
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[0]: Refreshing state... [id=rtbassoc-078826123f715261f]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Refreshing state... [id=nat-0815b28b77fe851e7]
module.aws-base-network.aws_route.public_internet_route[1]: Refreshing state... [id=r-rtb-0d07bd9a5b4f4b0eb1080289494]
module.aws-base-network.aws_route.public_internet_route[0]: Refreshing state... [id=r-rtb-09ef5f36565c48f0e1080289494]
module.aws-base-network.aws_route.private_internet_route[0]: Refreshing state... [id=r-rtb-0c27ed5fe2ca3b9f01080289494]
module.aws-base-network.aws_route.private_internet_route[1]: Refreshing state... [id=r-rtb-0e847cb6edba2f6891080289494]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # module.aws-base-network.aws_eip.nat_eip[0] has been changed
  ~ resource "aws_eip" "nat_eip" {
      + association_id       = "eipassoc-075695e8abd1200ca"
        id                   = "eipalloc-0592d600e74bfc740"
      + network_interface    = "eni-09e09c7232726bdb6"
      + private_dns          = "ip-192-168-20-116.ec2.internal"
      + private_ip           = "192.168.20.116"
        tags                 = {
            "Name" = "dev-nat-eip-us-east-1a"
        }
        # (7 unchanged attributes hidden)
    }
  # module.aws-base-network.aws_route_table.public_subnets_route_table[1] has been changed
  ~ resource "aws_route_table" "public_subnets_route_table" {
        id               = "rtb-0d07bd9a5b4f4b0eb"
      ~ route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = "igw-0462f3e8568d71a8c"
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
        tags             = {
            "Name" = "dev-public-rt-us-east-1b"
        }
        # (5 unchanged attributes hidden)
    }
  # module.aws-base-network.aws_route_table.public_subnets_route_table[0] has been changed
  ~ resource "aws_route_table" "public_subnets_route_table" {
        id               = "rtb-09ef5f36565c48f0e"
      ~ route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = "igw-0462f3e8568d71a8c"
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
        tags             = {
            "Name" = "dev-public-rt-us-east-1a"
        }
        # (5 unchanged attributes hidden)
    }
  # module.aws-base-network.aws_route_table.private_subnets_route_table[1] has been changed
  ~ resource "aws_route_table" "private_subnets_route_table" {
        id               = "rtb-0e847cb6edba2f689"
      ~ route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = "nat-0815b28b77fe851e7"
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
        tags             = {
            "Name" = "dev-private-rt-us-east-1b"
        }
        # (5 unchanged attributes hidden)
    }
  # module.aws-base-network.aws_route_table.private_subnets_route_table[0] has been changed
  ~ resource "aws_route_table" "private_subnets_route_table" {
        id               = "rtb-0c27ed5fe2ca3b9f0"
      ~ route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = "nat-0815b28b77fe851e7"
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
        tags             = {
            "Name" = "dev-private-rt-us-east-1a"
        }
        # (5 unchanged attributes hidden)
    }

Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or
respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.aws-base-network.aws_eip.nat_eip[0] will be destroyed
  - resource "aws_eip" "nat_eip" {
      - association_id       = "eipassoc-075695e8abd1200ca" -> null
      - domain               = "vpc" -> null
      - id                   = "eipalloc-0592d600e74bfc740" -> null
      - network_border_group = "us-east-1" -> null
      - network_interface    = "eni-09e09c7232726bdb6" -> null
      - private_dns          = "ip-192-168-20-116.ec2.internal" -> null
      - private_ip           = "192.168.20.116" -> null
      - public_dns           = "ec2-52-6-30-1.compute-1.amazonaws.com" -> null
      - public_ip            = "52.6.30.1" -> null
      - public_ipv4_pool     = "amazon" -> null
      - tags                 = {
          - "Name" = "dev-nat-eip-us-east-1a"
        } -> null
      - tags_all             = {
          - "Name" = "dev-nat-eip-us-east-1a"
        } -> null
      - vpc                  = true -> null
    }

  # module.aws-base-network.aws_internet_gateway.internet_gw will be destroyed
  - resource "aws_internet_gateway" "internet_gw" {
      - arn      = "arn:aws:ec2:us-east-1:013013717360:internet-gateway/igw-0462f3e8568d71a8c" -> null
      - id       = "igw-0462f3e8568d71a8c" -> null
      - owner_id = "013013717360" -> null
      - tags     = {
          - "Name" = "dev-internet-gw"
        } -> null
      - tags_all = {
          - "Name" = "dev-internet-gw"
        } -> null
      - vpc_id   = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_nat_gateway.nat_gw[0] will be destroyed
  - resource "aws_nat_gateway" "nat_gw" {
      - allocation_id        = "eipalloc-0592d600e74bfc740" -> null
      - connectivity_type    = "public" -> null
      - id                   = "nat-0815b28b77fe851e7" -> null
      - network_interface_id = "eni-09e09c7232726bdb6" -> null
      - private_ip           = "192.168.20.116" -> null
      - public_ip            = "52.6.30.1" -> null
      - subnet_id            = "subnet-06ba39c6fc5ecfa13" -> null
      - tags                 = {
          - "Name" = "dev-nat-gw-us-east-1a"
        } -> null
      - tags_all             = {
          - "Name" = "dev-nat-gw-us-east-1a"
        } -> null
    }

  # module.aws-base-network.aws_route.private_internet_route[0] will be destroyed
  - resource "aws_route" "private_internet_route" {
      - destination_cidr_block = "0.0.0.0/0" -> null
      - id                     = "r-rtb-0c27ed5fe2ca3b9f01080289494" -> null
      - nat_gateway_id         = "nat-0815b28b77fe851e7" -> null
      - origin                 = "CreateRoute" -> null
      - route_table_id         = "rtb-0c27ed5fe2ca3b9f0" -> null
      - state                  = "active" -> null
    }

  # module.aws-base-network.aws_route.private_internet_route[1] will be destroyed
  - resource "aws_route" "private_internet_route" {
      - destination_cidr_block = "0.0.0.0/0" -> null
      - id                     = "r-rtb-0e847cb6edba2f6891080289494" -> null
      - nat_gateway_id         = "nat-0815b28b77fe851e7" -> null
      - origin                 = "CreateRoute" -> null
      - route_table_id         = "rtb-0e847cb6edba2f689" -> null
      - state                  = "active" -> null
    }

  # module.aws-base-network.aws_route.public_internet_route[0] will be destroyed
  - resource "aws_route" "public_internet_route" {
      - destination_cidr_block = "0.0.0.0/0" -> null
      - gateway_id             = "igw-0462f3e8568d71a8c" -> null
      - id                     = "r-rtb-09ef5f36565c48f0e1080289494" -> null
      - origin                 = "CreateRoute" -> null
      - route_table_id         = "rtb-09ef5f36565c48f0e" -> null
      - state                  = "active" -> null
    }

  # module.aws-base-network.aws_route.public_internet_route[1] will be destroyed
  - resource "aws_route" "public_internet_route" {
      - destination_cidr_block = "0.0.0.0/0" -> null
      - gateway_id             = "igw-0462f3e8568d71a8c" -> null
      - id                     = "r-rtb-0d07bd9a5b4f4b0eb1080289494" -> null
      - origin                 = "CreateRoute" -> null
      - route_table_id         = "rtb-0d07bd9a5b4f4b0eb" -> null
      - state                  = "active" -> null
    }

  # module.aws-base-network.aws_route_table.private_subnets_route_table[0] will be destroyed
  - resource "aws_route_table" "private_subnets_route_table" {
      - arn              = "arn:aws:ec2:us-east-1:013013717360:route-table/rtb-0c27ed5fe2ca3b9f0" -> null
      - id               = "rtb-0c27ed5fe2ca3b9f0" -> null
      - owner_id         = "013013717360" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = ""
              - instance_id                = ""
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = "nat-0815b28b77fe851e7"
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "dev-private-rt-us-east-1a"
        } -> null
      - tags_all         = {
          - "Name" = "dev-private-rt-us-east-1a"
        } -> null
      - vpc_id           = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_route_table.private_subnets_route_table[1] will be destroyed
  - resource "aws_route_table" "private_subnets_route_table" {
      - arn              = "arn:aws:ec2:us-east-1:013013717360:route-table/rtb-0e847cb6edba2f689" -> null
      - id               = "rtb-0e847cb6edba2f689" -> null
      - owner_id         = "013013717360" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = ""
              - instance_id                = ""
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = "nat-0815b28b77fe851e7"
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "dev-private-rt-us-east-1b"
        } -> null
      - tags_all         = {
          - "Name" = "dev-private-rt-us-east-1b"
        } -> null
      - vpc_id           = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_route_table.public_subnets_route_table[0] will be destroyed
  - resource "aws_route_table" "public_subnets_route_table" {
      - arn              = "arn:aws:ec2:us-east-1:013013717360:route-table/rtb-09ef5f36565c48f0e" -> null
      - id               = "rtb-09ef5f36565c48f0e" -> null
      - owner_id         = "013013717360" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-0462f3e8568d71a8c"
              - instance_id                = ""
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = ""
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "dev-public-rt-us-east-1a"
        } -> null
      - tags_all         = {
          - "Name" = "dev-public-rt-us-east-1a"
        } -> null
      - vpc_id           = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_route_table.public_subnets_route_table[1] will be destroyed
  - resource "aws_route_table" "public_subnets_route_table" {
      - arn              = "arn:aws:ec2:us-east-1:013013717360:route-table/rtb-0d07bd9a5b4f4b0eb" -> null
      - id               = "rtb-0d07bd9a5b4f4b0eb" -> null
      - owner_id         = "013013717360" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-0462f3e8568d71a8c"
              - instance_id                = ""
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = ""
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "dev-public-rt-us-east-1b"
        } -> null
      - tags_all         = {
          - "Name" = "dev-public-rt-us-east-1b"
        } -> null
      - vpc_id           = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[0] will be destroyed
  - resource "aws_route_table_association" "private_internet_route_table_associations" {
      - id             = "rtbassoc-078826123f715261f" -> null
      - route_table_id = "rtb-0c27ed5fe2ca3b9f0" -> null
      - subnet_id      = "subnet-07fad8bbc6a36c7d2" -> null
    }

  # module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[1] will be destroyed
  - resource "aws_route_table_association" "private_internet_route_table_associations" {
      - id             = "rtbassoc-01bf3ede0ead5fb23" -> null
      - route_table_id = "rtb-0e847cb6edba2f689" -> null
      - subnet_id      = "subnet-0501c55da8ff10ddf" -> null
    }

  # module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[0] will be destroyed
  - resource "aws_route_table_association" "public_internet_route_table_associations" {
      - id             = "rtbassoc-0ef51a830c8deabdd" -> null
      - route_table_id = "rtb-09ef5f36565c48f0e" -> null
      - subnet_id      = "subnet-06ba39c6fc5ecfa13" -> null
    }

  # module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[1] will be destroyed
  - resource "aws_route_table_association" "public_internet_route_table_associations" {
      - id             = "rtbassoc-062bb45d12c8fe617" -> null
      - route_table_id = "rtb-0d07bd9a5b4f4b0eb" -> null
      - subnet_id      = "subnet-0ce192c925484c355" -> null
    }

  # module.aws-base-network.aws_subnet.private_subnets[0] will be destroyed
  - resource "aws_subnet" "private_subnets" {
      - arn                             = "arn:aws:ec2:us-east-1:013013717360:subnet/subnet-07fad8bbc6a36c7d2" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "us-east-1a" -> null
      - availability_zone_id            = "use1-az1" -> null
      - cidr_block                      = "192.168.128.0/19" -> null
      - id                              = "subnet-07fad8bbc6a36c7d2" -> null
      - map_customer_owned_ip_on_launch = false -> null
      - map_public_ip_on_launch         = false -> null
      - owner_id                        = "013013717360" -> null
      - tags                            = {
          - "Name" = "dev-private-net-us-east-1a"
        } -> null
      - tags_all                        = {
          - "Name" = "dev-private-net-us-east-1a"
        } -> null
      - vpc_id                          = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_subnet.private_subnets[1] will be destroyed
  - resource "aws_subnet" "private_subnets" {
      - arn                             = "arn:aws:ec2:us-east-1:013013717360:subnet/subnet-0501c55da8ff10ddf" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "us-east-1b" -> null
      - availability_zone_id            = "use1-az2" -> null
      - cidr_block                      = "192.168.160.0/19" -> null
      - id                              = "subnet-0501c55da8ff10ddf" -> null
      - map_customer_owned_ip_on_launch = false -> null
      - map_public_ip_on_launch         = false -> null
      - owner_id                        = "013013717360" -> null
      - tags                            = {
          - "Name" = "dev-private-net-us-east-1b"
        } -> null
      - tags_all                        = {
          - "Name" = "dev-private-net-us-east-1b"
        } -> null
      - vpc_id                          = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_subnet.public_subnets[0] will be destroyed
  - resource "aws_subnet" "public_subnets" {
      - arn                             = "arn:aws:ec2:us-east-1:013013717360:subnet/subnet-06ba39c6fc5ecfa13" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "us-east-1a" -> null
      - availability_zone_id            = "use1-az1" -> null
      - cidr_block                      = "192.168.0.0/19" -> null
      - id                              = "subnet-06ba39c6fc5ecfa13" -> null
      - map_customer_owned_ip_on_launch = false -> null
      - map_public_ip_on_launch         = true -> null
      - owner_id                        = "013013717360" -> null
      - tags                            = {
          - "Name" = "dev-public-net-us-east-1a"
        } -> null
      - tags_all                        = {
          - "Name" = "dev-public-net-us-east-1a"
        } -> null
      - vpc_id                          = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_subnet.public_subnets[1] will be destroyed
  - resource "aws_subnet" "public_subnets" {
      - arn                             = "arn:aws:ec2:us-east-1:013013717360:subnet/subnet-0ce192c925484c355" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "us-east-1b" -> null
      - availability_zone_id            = "use1-az2" -> null
      - cidr_block                      = "192.168.32.0/19" -> null
      - id                              = "subnet-0ce192c925484c355" -> null
      - map_customer_owned_ip_on_launch = false -> null
      - map_public_ip_on_launch         = true -> null
      - owner_id                        = "013013717360" -> null
      - tags                            = {
          - "Name" = "dev-public-net-us-east-1b"
        } -> null
      - tags_all                        = {
          - "Name" = "dev-public-net-us-east-1b"
        } -> null
      - vpc_id                          = "vpc-004befea10bbb3dac" -> null
    }

  # module.aws-base-network.aws_vpc.vpc will be destroyed
  - resource "aws_vpc" "vpc" {
      - arn                              = "arn:aws:ec2:us-east-1:013013717360:vpc/vpc-004befea10bbb3dac" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "192.168.0.0/16" -> null
      - default_network_acl_id           = "acl-0a5f47af80c4077ea" -> null
      - default_route_table_id           = "rtb-056765255a0690ddf" -> null
      - default_security_group_id        = "sg-0b0fb7da0ef4da7ab" -> null
      - dhcp_options_id                  = "dopt-1cb35566" -> null
      - enable_classiclink               = false -> null
      - enable_classiclink_dns_support   = false -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-004befea10bbb3dac" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-056765255a0690ddf" -> null
      - owner_id                         = "013013717360" -> null
      - tags                             = {
          - "Name" = "dev-vpc"
        } -> null
      - tags_all                         = {
          - "Name" = "dev-vpc"
        } -> null
    }

Plan: 0 to add, 0 to change, 20 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[0]: Destroying... [id=rtbassoc-0ef51a830c8deabdd]
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[1]: Destroying... [id=rtbassoc-01bf3ede0ead5fb23]
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[1]: Destroying... [id=rtbassoc-062bb45d12c8fe617]
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[0]: Destroying... [id=rtbassoc-078826123f715261f]
module.aws-base-network.aws_route.private_internet_route[1]: Destroying... [id=r-rtb-0e847cb6edba2f6891080289494]
module.aws-base-network.aws_route.public_internet_route[1]: Destroying... [id=r-rtb-0d07bd9a5b4f4b0eb1080289494]
module.aws-base-network.aws_route.public_internet_route[0]: Destroying... [id=r-rtb-09ef5f36565c48f0e1080289494]
module.aws-base-network.aws_route.private_internet_route[0]: Destroying... [id=r-rtb-0c27ed5fe2ca3b9f01080289494]
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[0]: Destruction complete after 1s
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[1]: Destruction complete after 1s
module.aws-base-network.aws_route_table_association.private_internet_route_table_associations[1]: Destruction complete after 1s
module.aws-base-network.aws_route_table_association.public_internet_route_table_associations[0]: Destruction complete after 1s
module.aws-base-network.aws_subnet.private_subnets[1]: Destroying... [id=subnet-0501c55da8ff10ddf]
module.aws-base-network.aws_subnet.private_subnets[0]: Destroying... [id=subnet-07fad8bbc6a36c7d2]
module.aws-base-network.aws_route.private_internet_route[1]: Destruction complete after 1s
module.aws-base-network.aws_route.private_internet_route[0]: Destruction complete after 1s
module.aws-base-network.aws_route.public_internet_route[1]: Destruction complete after 1s
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Destroying... [id=nat-0815b28b77fe851e7]
module.aws-base-network.aws_route_table.private_subnets_route_table[1]: Destroying... [id=rtb-0e847cb6edba2f689]
module.aws-base-network.aws_route_table.private_subnets_route_table[0]: Destroying... [id=rtb-0c27ed5fe2ca3b9f0]
module.aws-base-network.aws_route.public_internet_route[0]: Destruction complete after 2s
module.aws-base-network.aws_route_table.public_subnets_route_table[0]: Destroying... [id=rtb-09ef5f36565c48f0e]
module.aws-base-network.aws_route_table.public_subnets_route_table[1]: Destroying... [id=rtb-0d07bd9a5b4f4b0eb]
module.aws-base-network.aws_subnet.private_subnets[0]: Destruction complete after 1s
module.aws-base-network.aws_subnet.private_subnets[1]: Destruction complete after 1s
module.aws-base-network.aws_route_table.private_subnets_route_table[0]: Destruction complete after 1s
module.aws-base-network.aws_route_table.private_subnets_route_table[1]: Destruction complete after 1s
module.aws-base-network.aws_route_table.public_subnets_route_table[1]: Destruction complete after 0s
module.aws-base-network.aws_route_table.public_subnets_route_table[0]: Destruction complete after 0s
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still destroying... [id=nat-0815b28b77fe851e7, 10s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still destroying... [id=nat-0815b28b77fe851e7, 20s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still destroying... [id=nat-0815b28b77fe851e7, 30s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Still destroying... [id=nat-0815b28b77fe851e7, 40s elapsed]
module.aws-base-network.aws_nat_gateway.nat_gw[0]: Destruction complete after 42s
module.aws-base-network.aws_internet_gateway.internet_gw: Destroying... [id=igw-0462f3e8568d71a8c]
module.aws-base-network.aws_subnet.public_subnets[1]: Destroying... [id=subnet-0ce192c925484c355]
module.aws-base-network.aws_eip.nat_eip[0]: Destroying... [id=eipalloc-0592d600e74bfc740]
module.aws-base-network.aws_subnet.public_subnets[0]: Destroying... [id=subnet-06ba39c6fc5ecfa13]
module.aws-base-network.aws_subnet.public_subnets[0]: Destruction complete after 1s
module.aws-base-network.aws_subnet.public_subnets[1]: Destruction complete after 1s
module.aws-base-network.aws_eip.nat_eip[0]: Destruction complete after 1s
module.aws-base-network.aws_internet_gateway.internet_gw: Still destroying... [id=igw-0462f3e8568d71a8c, 10s elapsed]
module.aws-base-network.aws_internet_gateway.internet_gw: Destruction complete after 11s
module.aws-base-network.aws_vpc.vpc: Destroying... [id=vpc-004befea10bbb3dac]
module.aws-base-network.aws_vpc.vpc: Destruction complete after 0s

Destroy complete! Resources: 20 destroyed.
```