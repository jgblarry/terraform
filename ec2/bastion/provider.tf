# REMOTE STATE CONFIGURE
terraform {
  backend "s3" {
    bucket = "jgblarry-terraform"
    key    = "states/bastion_terraform.tfstate"
    region = "eu-west-1"
  }
}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "jgblarry-terraform"
    key    = "states/vcp_terraform.tfstate"
    region = "eu-west-1"
  }
}

# Configuracion del provider AWS
provider "aws" {
  version = "~> 2.8"
  region  = "${var.region}"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

#Date selections for ec2 instances

data "aws_ami" "ubuntu16" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

data "aws_ami" "ubuntu18" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
  owners = ["amazon"] # Canonical
}
