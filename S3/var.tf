variable "bucket_name" {
    default = "terraform-up-and-running-state-metadata123456"
}

variable "acl_value" {
    default = "private"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
    default = "us-west-2"
}