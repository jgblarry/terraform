#CREATE S3 Bucket ELB Logs
data "aws_elb_service_account" "this" {}

resource "aws_s3_bucket" "elb_logs" {
  bucket        = "${var.bucket_elb_logs}"
  acl           = "private"
  policy        = "${data.aws_iam_policy_document.logs.json}"
  force_destroy = true

  tags = {
    Name        = "${var.bucket_elb_logs}"
    Environment = "${var.env}"
  }
}
data "aws_iam_policy_document" "logs" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.this.arn}"]
    }

    resources = [
      "arn:aws:s3:::${var.bucket_elb_logs}/*",
    ]
  }
}
#CREATE SG ELB
module "complete_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.0"
  name        = "${var.sg_elb_name}"
  description = "Security group for Bastion usage with EC2 instance"
  vpc_id      = "${data.terraform_remote_state.vpc.outputs.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_rules = ["all-all"]
}

#CREATE ELB RESOURCE
resource "aws_elb" "new_elb" {
  name               = "${var.elb_name}"
  subnets         = ["${data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]}", "${data.terraform_remote_state.vpc.outputs.public_subnet_ids[1]}"]
  security_groups = ["${module.complete_sg.this_security_group_id}"]
  internal        = false

  access_logs {
    bucket        = "${var.bucket_elb_logs}"
    bucket_prefix = "elb"
    interval      = 60
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  #listener {
  #  instance_port      = 80
  #  instance_protocol  = "http"
  #  lb_port            = 443
  #  lb_protocol        = "https"
  #  ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  #}

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }

  #instances                   = ["${aws_instance.foo.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
  connection_draining         = true
  connection_draining_timeout = 60

  tags  = {
      Name = "${var.elb_name}"
      Create_by = "${var.creator}"
      Project = "${var.project}"
      Environment = "${var.env}"
      Terraform = "${var.terraform}"
    }
}