# Introduction 
Test: Creation of an EC2 instance with a VPC using terraform. Terraform state files to be uploaded to an s3 bucket.

Action Plan
create s3 bucket 
create VPC
create EC2 instance
Use s3 bucket as backend

# Steps taken for s3

- Project defined in two folder EC2 for the instance and the VPC

- IAM permissions granted for identities to be used in resource creation.

Summary of access creation:

1. Login to your AWS Account

2. Select IAM. In Management Console, search for IAM.

3. On the left side of the panel, select User.

4. Select Add Users and enter details.

5. Attach policy

6. Create User.


> Access is pulled from our terraform.tfvars file. Normally, I will have used the option (sensitive = true) however for the purpose of the simple presentation I chose to leave as is
> In the bucket.tf we defined the bucket and used var.tf to define our variables
> var.tf is used to declare values of variables. We can either provide a default value to be used when needed or ask for value during execution. Access key, Secret key, and Region will be defined here. Access key, Secret key, and Region will be defined here.
> In main.tf we define the main set of configs


# S3 bucket creation: I created the S3 bucket first since we will be using it for the state file
> For the S3 we have a local tfstate file since the S3 bucket will be used to store our state files for the EC2 and VPC's
> We also provisioned a dyndamodb resource for the tables

After creating the s3 files we proceeded to run the: terraform init; terraform plan; terraform apply



# Steps taken for EC2 and VPC

Define Environment variables: set the ACCESS_KEY_ID and SECRET_ACCESS_KEY as environment variables

$Env:AWS_DEFAULT_REGION="us-west-2"
$Env:AWS_SECRET_ACCESS_KEY="******************"
$Env:AWS_ACCESS_KEY_ID="***************8"

> I used modules for our EC2 and VPC as defined thus: https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest and https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

> This configuration includes four blocks:
- terraform configures Terraform itself. This block requires the aws provider from the official Hashicorp provider registry.
- provider "aws" defines my provider. Depending on the authentication method you chose, you may need to include additional arguments in the provider block.
- module "vpc" defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.
- module "ec2_instances" defines the EC2 instance within the VPC.

> For our provider I used the https://registry.terraform.io/providers/hashicorp/aws/latest/docs
> Terraform has installed the provider and both of the modules my configuration refers to.

> For our s3 backend in the main.tf we provided values from https://www.terraform.io/language/settings/backends/s3#access_key while using our previously created ENV variables

> We outputted the EC2 IP and the VPC subnets

I proceeded to run terraform apply


Commands used during config:

terraform init 
terraform init -reconfigure  
terraform validate
terraform apply
terraform plan
Terraform destroy
Install-Module -Name AWS.Tools.Installer -Force (to install aws tools)


Code Output:

Running terraform apply on our EC2 folder created the resources. See output below

 + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Environment" = "metadata"
          + "Name"        = "metadatainstance"
          + "Terraform"   = "true"
        }
      + tags_all                             = {
          + "Environment" = "metadata"
          + "Name"        = "metadatainstance"
          + "Terraform"   = "true"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + volume_tags                          = {
          + "Name" = "metadatainstance"
        }
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + credit_specification {}

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_put_response_hop_limit = 1
          + http_tokens                 = "optional"
          + instance_metadata_tags      = "disabled"
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + timeouts {}
    }

  # module.vpc.aws_internet_gateway.this[0] will be created
  + resource "aws_internet_gateway" "this" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc"
          + "Terraform"   = "true"
        }
      + tags_all = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc"
          + "Terraform"   = "true"
        }
      + vpc_id   = (known after apply)
    }

  # module.vpc.aws_route.public_internet_gateway[0] will be created
  + resource "aws_route" "public_internet_gateway" {
      + destination_cidr_block = "0.0.0.0/0"
      + gateway_id             = (known after apply)
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + route_table_id         = (known after apply)
      + state                  = (known after apply)

      + timeouts {
          + create = "5m"
        }
    }

  # module.vpc.aws_route_table.private[0] will be created
  + resource "aws_route_table" "private" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-private-us-west-2a"
          + "Terraform"   = "true"
        }
      + tags_all         = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-private-us-west-2a"
          + "Terraform"   = "true"
        }
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table.public[0] will be created
  + resource "aws_route_table" "public" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = (known after apply)
      + tags             = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-public"
          + "Terraform"   = "true"
        }
      + tags_all         = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-public"
          + "Terraform"   = "true"
        }
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table_association.private[0] will be created
  + resource "aws_route_table_association" "private" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_route_table_association.public[0] will be created
  + resource "aws_route_table_association" "public" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_subnet.private[0] will be created
  + resource "aws_subnet" "private" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-private-us-west-2a"
          + "Terraform"   = "true"
        }
      + tags_all                                       = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-private-us-west-2a"
          + "Terraform"   = "true"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.public[0] will be created
  + resource "aws_subnet" "public" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.101.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-public-us-west-2a"
          + "Terraform"   = "true"
        }
      + tags_all                                       = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc-public-us-west-2a"
          + "Terraform"   = "true"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_vpc.this[0] will be created
  + resource "aws_vpc" "this" {
      + arn                                  = (known after apply)
      + assign_generated_ipv6_cidr_block     = false
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = false
      + enable_dns_support                   = true
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc"
          + "Terraform"   = "true"
        }
      + tags_all                             = {
          + "Environment" = "metadata"
          + "Name"        = "metadata-vpc"
          + "Terraform"   = "true"
        }
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + ec2_instance_public_ips = (known after apply)
  + vpc_public_subnets      = [
      + (known after apply),
    ]

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.vpc.aws_vpc.this[0]: Creating...
module.vpc.aws_vpc.this[0]: Still creating... [10s elapsed]
module.vpc.aws_vpc.this[0]: Creation complete after 13s [id=vpc-09dc0595e8bac2ab4]
module.vpc.aws_internet_gateway.this[0]: Creating...
module.vpc.aws_route_table.public[0]: Creating...
module.vpc.aws_route_table.private[0]: Creating...
module.vpc.aws_subnet.private[0]: Creating...
module.vpc.aws_subnet.public[0]: Creating...
module.vpc.aws_route_table.private[0]: Creation complete after 3s [id=rtb-0e082ef4c775be5ae]
module.vpc.aws_route_table.public[0]: Creation complete after 3s [id=rtb-0bb6aa5b7e375730c]
module.vpc.aws_subnet.private[0]: Creation complete after 4s [id=subnet-0f05dd18e54e8d64a]
module.vpc.aws_route_table_association.private[0]: Creating...
module.vpc.aws_internet_gateway.this[0]: Creation complete after 5s [id=igw-0e6e5d89ddddac051]
module.vpc.aws_route.public_internet_gateway[0]: Creating...
module.vpc.aws_route_table_association.private[0]: Creation complete after 3s [id=rtbassoc-07a4c9b52c6d5fbb4]
module.vpc.aws_route.public_internet_gateway[0]: Creation complete after 5s [id=r-rtb-0bb6aa5b7e375730c1080289494]
module.vpc.aws_subnet.public[0]: Still creating... [10s elapsed]
module.vpc.aws_subnet.public[0]: Creation complete after 16s [id=subnet-087d6e0f50395bf27]
module.vpc.aws_route_table_association.public[0]: Creating...
module.ec2_instances.aws_instance.this[0]: Creating...
module.vpc.aws_route_table_association.public[0]: Creation complete after 4s [id=rtbassoc-0df29f755af7b3f5d]
module.ec2_instances.aws_instance.this[0]: Still creating... [10s elapsed]
module.ec2_instances.aws_instance.this[0]: Still creating... [20s elapsed]
module.ec2_instances.aws_instance.this[0]: Still creating... [30s elapsed]
module.ec2_instances.aws_instance.this[0]: Still creating... [40s elapsed]
module.ec2_instances.aws_instance.this[0]: Creation complete after 49s [id=i-020237151cc6136a0]
Releasing state lock. This may take a few moments...

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

ec2_instance_public_ips = "34.221.171.153"
vpc_public_subnets = [
  "subnet-087d6e0f50395bf27",
]


I proceeded to clean up the infrastructure using Terraform destroy