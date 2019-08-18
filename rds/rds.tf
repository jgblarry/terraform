#CREATE SECURITY GROUPS
module "complete_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.0"
  name        = "sg_rds_${var.env}"
  description = "Security group for RDS instance"
  vpc_id      = "${data.terraform_remote_state.vpc.outputs.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "mysql-tcp"
      cidr_blocks = "${data.terraform_remote_state.vpc.outputs.vpc_cidr}"
    },
    {
      rule        = "mysql-tcp"
      cidr_blocks = "52.59.163.150/32"
    },
  ]

  egress_rules = ["all-all"]
}

#CREATE BBDD

module "db" {
  source     = "terraform-aws-modules/rds/aws"
  version    = "~> 2.0"
  identifier = "${var.rds_name}"

  engine            = "${var.engine}"
  engine_version    = "${var.version_engine}"
  instance_class    = "${var.db_class}"
  allocated_storage = "${var.rds_storage}"

  name     = "${var.rds_name}"
  username = "${var.admin_user}"
  password = "${var.admin_passwd}"
  port     = "3306"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = ["${module.complete_sg.this_security_group_id}"]

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 15

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically

  #monitoring_interval    = "60"
  #monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true
  multi_az               = "${var.multi_az}"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "snapshot-${var.rds_name}"

  # Database Deletion Protection
  deletion_protection             = "${var.delete_protection}"
  enabled_cloudwatch_logs_exports = ["audit", "general"]

  tags = {
    Create_by   = "${var.creator}"
    Project     = "${var.project}"
    Environment = "${var.env}"
    Terraform   = "${var.terraform}"
  }
  subnet_ids           = ["${data.terraform_remote_state.vpc.outputs.database_subnet_ids[0]}", "${data.terraform_remote_state.vpc.outputs.database_subnet_ids[1]}"]
  family               = "${var.db_family}"
  major_engine_version = "${var.major_engine_version}"

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
 