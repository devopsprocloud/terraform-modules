data "aws_availability_zones" "azs" {
  
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_route_table" "default_rt" {
  vpc_id = data.aws_vpc.default_vpc.id
    filter {
      name = "association.main"
      values = ["true"]
    }
}