#TERRAFORM STATE
variable "region" {
  default = "eu-west-2"
}
variable "region_bucket" {
  default = "eu-west-1"
}

#INSTANCIA
variable "rsa_bits" {
  description = "(Optional) When algorithm is \"RSA\", the size of the generated RSA key in bits. Defaults to \"2048\"."
  default     = "2048"
}
variable "namespace" {
  description = "Need the module ssh-key-pair"
  default     = "cp"
}
variable "stage" {
  description = "Need the module ssh-key-pair"
  default     = "prod"
}
variable "bastion-key-name" {
  description = "Need the module ssh-key-pair"
  default     = "bastion-jenkins"
}
variable "instance-type" {
  description = "Instance Type from the bastion"
  default     = "t3.small"
}
#TAGS
variable "bastion_name" {
  description = "(Optional) Name of AWS keypair that will be created"
  default     = "bastion-jenkins"
}
variable "env" {
  description = "Environment type"
  default     = "Prod"
}
variable "project" {
  description = "Project name"
  default     = "Terraform"
}
variable "creator" {
  description = "Deploymente by"
  default     = "Nubersia"
}
variable "terraform" {
  description = "Terraform Template"
  default     = "true"
}

variable "bastion_userdata" {
  description = "File Script from configure instance"
  default     = "userdata_bastion_amz.tpl"
}