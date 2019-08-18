#OUTPUT

output "sg_id_rds" {
  description = "The ID of the RDS security group"
  value       = "${module.complete_sg.this_security_group_id}"
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = "${module.db.this_db_instance_address}"
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.db.this_db_instance_arn}"
}



output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = "${module.db.this_db_instance_availability_zone}"
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${module.db.this_db_instance_endpoint}"
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${module.db.this_db_instance_hosted_zone_id}"
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = "${module.db.this_db_instance_id}"
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = "${module.db.this_db_instance_resource_id}"
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = "${module.db.this_db_instance_status}"
}

output "db_instance_name" {
  description = "The database name"
  value       = "${module.db.this_db_instance_name}"
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = "${var.admin_user}"
}

output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = "${var.admin_passwd}"
}

output "db_instance_port" {
  description = "The database port"
  value       = "${module.db.this_db_instance_port}"
}
