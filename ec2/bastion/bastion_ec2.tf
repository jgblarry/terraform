#CREATE SECURITY GROUPS
module "complete_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.0"
  name        = "sg_bastion_jenkins"
  description = "Security group for Bastion usage with EC2 instance"
  vpc_id      = "${data.terraform_remote_state.vpc.outputs.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = "52.59.163.150/32"
    },
  ]

  egress_rules = ["all-all"]
}

#CREATE SSH KEY PAIR FOR THE INSTANCE BASTION
module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-tls-ssh-key-pair.git?ref=master"
  namespace             = "${var.namespace}"
  stage                 = "${var.stage}"
  name                  = "${var.bastion-key-name}"
  ssh_public_key_path   = "./.key"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
  chmod_command         = "chmod 600 %v"
}
resource "aws_key_pair" "bastion-jenkins" {
  key_name   = "${var.bastion_name}"
  public_key = "${module.ssh_key_pair.public_key}"
}

#CREATE ROLE IAM
resource "aws_iam_role" "bastion_role" {
  name               = "bastion_role"
  assume_role_policy = "${file("iam_bastion_role.json")}"
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_profile"
  role = "${aws_iam_role.bastion_role.name}"
}

resource "aws_iam_policy" "bastion_policy" {
  name        = "bastion_policy"
  description = "A bation policy"
  policy      = "${file("iam_bastion_policy.json")}"
}

resource "aws_iam_policy_attachment" "bation_attach" {
  name       = "bastion_attachment"
  roles      = ["${aws_iam_role.bastion_role.name}"]
  policy_arn = "${aws_iam_policy.bastion_policy.arn}"
}

#CREATE EC2 INSTANCE BASTION
data "template_file" "userdata" {
  template = "${file(var.bastion_userdata)}"
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"
  name    = "Bastion-Jenkins"

  #instance_count         = "1"
  ami                         = "${data.aws_ami.amazon.id}"
  instance_type               = "${var.instance-type}"
  key_name                    = "${var.bastion_name}"
  monitoring                  = true
  user_data                   = "${data.template_file.userdata.rendered}"
  iam_instance_profile        = "${aws_iam_instance_profile.bastion_profile.name}"
  vpc_security_group_ids      = ["${module.complete_sg.this_security_group_id}"]
  #associate_public_ip_address = true
  subnet_id                   = "${data.terraform_remote_state.vpc.outputs.public_subnet_ids[2]}"

  tags = {
    Terraform   = "${var.terraform}"
    Environment = "${var.env}"
    Create_by   = "${var.creator}"
    Project     = "${var.project}"

  }
}
