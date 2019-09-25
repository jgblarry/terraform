# Add Module VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.0.0"
  name    = "VPC_${var.project}_${var.env}"
  cidr    = "${var.vpc_cidr}"

  #Subnets
  #azs              = ["${data.aws_availability_zones.available.names}"]
  azs              = ["${var.azs[0]}", "${var.azs[1]}", "${var.azs[2]}"]
  public_subnets   = ["${var.vpc_subnet_cidr[0]}", "${var.vpc_subnet_cidr[1]}", "${var.vpc_subnet_cidr[2]}"]
  private_subnets  = ["${var.vpc_subnet_cidr[3]}", "${var.vpc_subnet_cidr[4]}", "${var.vpc_subnet_cidr[5]}"]
  database_subnets = ["${var.vpc_subnet_cidr[6]}", "${var.vpc_subnet_cidr[7]}", "${var.vpc_subnet_cidr[8]}"]

  #Internet Gateway Tags
  igw_tags = {
    name = "IGW_VPC_${var.project}_${var.env}"
  }

  # One NAT Gateway per Availability Zone
  enable_nat_gateway = true

  #If both single_nat_gateway and one_nat_gateway_per_az are set to true, then single_nat_gateway takes precedence.
  single_nat_gateway = true
  #one_nat_gateway_per_az = true

  #enable_vpn_gateway     = true

  tags = {
    Terraform   = "true"
    Environment = "${var.env}"
    Create      = "${var.create}"
    Project     = "${var.project}"
  }
}