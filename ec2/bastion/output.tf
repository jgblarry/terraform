output "bastion_id" {
  value = "${module.ec2_cluster.id}"
}

output "bastion_public_ip" {
  value = "${module.ec2_cluster.public_ip}"
}

output "bastion_sg" {
  value = "${module.complete_sg.this_security_group_name}"
}

output "nic_id" {
  value = "${module.ec2_cluster.primary_network_interface_id}"
}
 