# REMOTE STATE CONFIGURE
terraform {
  backend "s3" {
    bucket = "jgblarry-terraform"
    key    = "states/aurora_terraform.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "jgblarry-terraform"
    key    = "states/vpc_terraform.tfstate"
    region = "eu-west-1"
  }
}

# Configuracion del provider AWS
provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}