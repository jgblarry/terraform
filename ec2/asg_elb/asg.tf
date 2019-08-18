#Create Launch Configurations
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "${var.lc_name}"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

#Create Auto Scaling Group
resource "aws_autoscaling_group" "AutoSG" {
  name                      = "${var.asg_name}"
  max_size                  = 0
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 0
  force_delete              = true
  #placement_group           = "${aws_placement_group.test.id}"
  launch_configuration      = "${aws_launch_configuration.as_conf.name}"
  vpc_zone_identifier       = ["${data.terraform_remote_state.vpc.outputs.private_subnet_ids[0]}", "${data.terraform_remote_state.vpc.outputs.private_subnet_ids[1]}"]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
    key                 = "Terraform"
    value               = "${var.terraform}"
    propagate_at_launch = true
    },
    {
    key                 = "Project"
    value               = "${var.project}"
    propagate_at_launch = true
    },
    {
    key                 = "Environment"
    value               = "${var.env}"
    propagate_at_launch = true
    },
    {
    key                 = "Create_by"
    value               = "${var.creator}"
    propagate_at_launch = true
    }
  ]
}

#ATTACH ELB TO ASG
resource "aws_autoscaling_attachment" "asg_attachment_AutoSG" {
  autoscaling_group_name = "${aws_autoscaling_group.AutoSG.id}"
  elb                    = "${data.terraform_remote_state.elb.outputs.elb_id}"
}