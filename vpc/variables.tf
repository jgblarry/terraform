variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = "string"
}

variable "azs" {
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
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

#variable "access_key" {
#}

/*variable "secret_key" {
}*/

variable "region" {
  default = "eu-west-2"
}

variable "project" {
  default = "JGB_proyecto"
}

variable "env" {
  default = "Desa"
}
variable "create" {
  default = "jgblarry"
}