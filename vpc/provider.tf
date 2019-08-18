#Config remote state
terraform {
  backend "s3" {
    bucket = "nubersia-terraform-state"
    key    = "states/nubersia/terraform.tfstate"
    region = "eu-west-1"
  }
}

# Configuracion del provider AWS
provider "aws" {
  version    = "~> 2.8"
  region     = var.region
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}