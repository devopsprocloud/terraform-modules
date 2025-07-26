module "roboshop_ec2" {
  source = "../ec2-module"
  instance_type = var.instance_type
  instance_tags = var.instance_tags
  # Variable name in ec2-module = variable we want to pass in roboshop-ec2

}