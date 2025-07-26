output "public_ip" {
  value = module.roboshop_ec2.public_ip
}

output "private_ip" {
  value = module.roboshop_ec2.private_ip
}

output "instance_id" {
  value = module.roboshop_ec2.instance_id
}