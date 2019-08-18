variable "region" {
  default = "eu-west-2"
}
variable "region_bucket" {
  default = "eu-west-1"
  type    = "string"

}

#RDS INSTANCE
variable "rds_name" {
  description = "El nombre de la instancia solo debe tener valores Alfanumerico"
  default     = "rdsprod"
}
variable "rds_storage" {
  description = "El storage debe ser superior a 20Gb"
  default     = "20"
}
variable "db_type" {
  description = "Los valores deben ser consultados "
  default     = "Mysql5.7"
}
variable "engine" {
  description = "Need the module ssh-key-pair"
  default     = "mysql"
}
variable "version_engine" {
  description = "Need the module ssh-key-pair"
  default     = "5.7.19"
}
variable "major_engine_version" {
  description = "Need the module ssh-key-pair"
  default     = "5.7"
}

variable "db_family" {
  description = "Need the module ssh-key-pair"
  default     = "mysql5.7"
}

variable "delete_protection" {
  description = "Need the module ssh-key-pair"
  default     = "false"
}
variable "db_class" {
  description = "Need the module ssh-key-pair"
  default     = "db.t3.medium"
}

variable "db_sg" {
  description = "Subnet Group"
  default     = "sg-bbdd-prod"
}
variable "admin_user" {
  description = "Instance Type from the bastion"
  default     = "admin"
}
variable "admin_passwd" {
  description = "Instance Type from the bastion"
  default     = "BhNk-iNahs.Kk"
}

variable "multi_az" {
  description = "Instance Type from the bastion"
  default     = "true"
}
#TAGS
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