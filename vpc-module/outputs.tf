output "azs" {
  value = data.aws_availability_zones.azs.names
}

output "vpc_id" {
  value = aws_vpc.vpc_module.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.database[*].id
}