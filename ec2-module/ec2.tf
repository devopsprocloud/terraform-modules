resource "aws_instance" "ec2_module" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  #vpc_security_group_ids = [aws_security_group.roboshop-all.id]

  tags = var.instance_tags
}
