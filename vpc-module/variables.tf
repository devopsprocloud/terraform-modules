variable "vpc_cidr" {
  type = string 
  default = "10.0.0.0/16"
}

variable "vpc_tags" {
    type = map 
    default = {}
}

variable "common_tags" {
    type = map 
    default = {}
}

variable "project_name" {
    type = string 
}

variable "environment" {
    type = string 
}

variable "igw_tags" {
    type = map 
    default = {}
}

variable "public_subnets_cidr" {
    type = list 
    validation {
      condition = length(var.public_subnets_cidr) == 2
      error_message = "Please provide 2 valid public subnet's cidr"
    }
}

variable "public_subnets_tags" {
    type = map 
    default = {}
}

variable "private_subnets_cidr" {
    type = list 
    validation {
      condition = length(var.private_subnets_cidr) == 2
      error_message = "Please provide 2 valid private subnet's cidr"
    }
}

variable "private_subnets_tags" {
    type = map 
    default = {}
}

variable "database_subnets_cidr" {
    type = list 
    validation {
      condition = length(var.database_subnets_cidr) == 2
      error_message = "Please provide 2 valid database subnet's cidr"
    }
}

variable "database_subnets_tags" {
    type = map 
    default = {}
}

variable "db_subnet_group_tags" {
    type = map 
    default = {}
}

variable "ngw_tags" {
  type = map 
  default = {}
}

variable "public_rt_tags" {
  type = map 
  default = {}
}

variable "private_rt_tags" {
  type = map 
  default = {}
}

variable "database_rt_tags" {
  type = map 
  default = {}
}

variable "is_peering_required" {
  type = bool
  default = false
}

variable "acceptor_vpc_id" {
  type = string 
  default = ""
}

variable "vpc_peering_tags" {
  type = map 
  default = {}
}