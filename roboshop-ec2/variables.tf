variable "instance_type" {
  default = "t3.medium"
}

variable "instance_tags" {
    type = map 
    default = {
        Name = "EC2_Module_VM"
        Project = "Roboshop"
        Environment = "DEV"
        Component = "Web"
        terraform = "True"
    }
}