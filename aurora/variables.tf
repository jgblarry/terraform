###################
## DEPLOY REGION ##
###################
variable "region" {
  default = "eu-west-1"
}
############################
## DEPLOY AURORA INSTANCE ##
############################
variable "aurora_name" {
  description = "The instance name, only alphanumeric chaaracter"
  default     = "prestashop-aurora-prod"
}
variable "aurora_engine" {
  description = "BBDD engine"
  default     = "aurora-mysql"
}
variable "version_engine" {
  description = "Version for BBDD engine"
  default     = "5.7.12"
}
variable "replica_count" {
  description = "Write and Read replica number to deploy"
  default     = "1"
}
variable "instance_type" {
  description = "Type instance to deploy"
  default     = "db.t3.small"
}
variable "pg_name" {
  description = "Name for parameters group"
  default     =  "pg-prod-aurora-db-57"
}
variable "db_family" {
  default     = "aurora-mysql5.7"
}
variable "iam_database_authentication_enabled" {
  default = "false"
}

variable "iam_aurora_policy" {
  description = "IAM Policy from aurora cluster"
  default = "prod-aurora-db-57-policy-iam-auth"  
}
variable "username" {
  description = "Usuario administrador para el RDS"
  default     = "admin"
}
variable "password" {
  description = "Se debe generar un Passwd por cada despliegue"
  default     = "BhNk-iNahs.Kk"
}
variable "database_name" {
  description = "Database name for default schema"
  default     = "prod_master"
}

###if you change the accessibility of the data to public,         ###
###you must modify the subnet before they can have public access  ###
variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = "true"
}

variable "backup_retention_period" {
  description = "The retention period from RDS snapshot"
  default = "30"
}

variable "monitoring_interval" {
  default = "60"
}

##############
## ADD TAGS ##
##############
variable "env" {
  description = "Environment type"
  default     = "Prod"
}
variable "project" {
  description = "Project name"
  default     = "Prestashop"
}
variable "creator" {
  description = "Deploymente by"
  default     = "Emilio-Reinaldo"
}
variable "terraform" {
  description = "Terraform Template"
  default     = "true"
}

