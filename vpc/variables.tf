variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = "string"
}

variable "azs" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  type    = "list"
}

variable "vpc_subnet_cidr" {
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]

  type = "list"
}

variable "access_key" {
}

variable "secret_key" {
}

variable "region" {
  default = "eu-west-1"
}

variable "project" {
  default = "Terraform"
}

variable "env" {
  default = "Prod"
}

