#VPC REGION _ AZs
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = "string"
}

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

#AZs CONFIG ELB
variable "elb_azs" {
  default = ["eu-west-2a", "eu-west-2b"]
  type    = "list"
}
#ELB CONFIG
variable "elb_name" {
  default = "PROD-ELB-Project"
  type    = "string"
}

variable "sg_elb_name" {
  default = "PROD-ELB-Project"
  type    = "string"
}

variable "bucket_elb_logs" {
  default = "nubersia-terraform-elblog"
  type    = "string"
}

#TAGS
variable "domain_acm" {
  default = "Terraform.com"
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
