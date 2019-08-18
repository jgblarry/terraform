#OUTPUT
output "elb_id" {
  description = "The name of the ELB"
  value       = aws_elb.new_elb.id
}

output "elb_dns" {
  description = "The DNS name of the ELB"
  value       = aws_elb.new_elb.dns_name
}

output "elb_sg" {
  description = "The Security Group of the ELB"
  value       = aws_elb.new_elb.security_groups
}

output "elb_subnet-group" {
  description = "The Security Group of the ELB"
  value       = aws_elb.new_elb.subnets
}
