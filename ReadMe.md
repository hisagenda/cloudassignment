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


C
