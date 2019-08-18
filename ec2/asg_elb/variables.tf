variable "azs" {
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  type    = "list"
}

variable "region" {
  default = "eu-west-2"
}
variable "region_bucket" {
  default = "eu-west-1"
  type    = "string"

}

#TAGS
variable "asg_name" {
  default = "ASG-001"
  type    = "string"
}

variable "lc_name" {
  default = "LC-001"
  type    = "string"
}

variable "env" {
  default = "Prod"
}
variable "project" {
  default = "Terraform"
}

variable "creator" {
  default = "Nubersia"
}

variable "terraform" {
  default = "true"
}
