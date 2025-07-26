# VPC --------------------------------------
resource "aws_vpc" "vpc_module" {
  cidr_block       = var.vpc_cidr

  tags = merge(var.common_tags, var.vpc_tags,
      {
        Name = "${local.name}"
      }
    )
}

# Internet Gateway --------------------------
  resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(var.common_tags, var.igw_tags,
      {
        Name = "${local.name}-igw"
      }
    )
}

# Public Subnet -----------------------------

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  vpc_id     = aws_vpc.vpc_module.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(var.common_tags, var.public_subnets_tags,
      {
        Name = "${local.name}-public-${local.azs[count.index]}"
      }
    )
}

# Private Subnet -----------------------------

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)
  vpc_id     = aws_vpc.vpc_module.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(var.common_tags, var.private_subnets_tags,
      {
        Name = "${local.name}-private-${local.azs[count.index]}"
      }
    )
}


# Database Subnet -----------------------------

resource "aws_subnet" "database" {
  count = length(var.database_subnets_cidr)
  vpc_id     = aws_vpc.vpc_module.id
  cidr_block = var.database_subnets_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(var.common_tags, var.database_subnets_tags,
      {
        Name = "${local.name}-database-${local.azs[count.index]}"
      }
    )
}

# Creating Databse subnet groups
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${local.name}-db-subnet-group"
  subnet_ids = aws_subnet.database[*].id

  tags = merge(var.common_tags, var.db_subnet_group_tags,
    {
        Name = "${local.name}-db-subnet-group"
    }
    )
}

# Elastic IP ----------------------------------------------

resource "aws_eip" "eip" {
  domain         = "vpc"
}

# NAT Gateway ----------------------------------------------

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id # we need to use [] when count parameter included
  # NAT gateway should assign to public subnet where has internet access

  tags = merge(var.common_tags, var.ngw_tags,
      {
          Name = "${local.name}-ngw"
      }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

# Route Tables  --------------------------------------------
# Public Route Table ---------------------------------------

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(var.common_tags, var.public_rt_tags,
  {
      Name = "${local.name}-public-rt"
  }
  )
}

# Private Route Table ----------------------------------------
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(var.common_tags, var.private_rt_tags,
  {
      Name = "${local.name}-private-rt"
  }
  )
}

# Database Route Table -----------------------------------------
resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(var.common_tags, var.database_rt_tags,
  {
      Name = "${local.name}-database-rt"
  }
  )
}

# Routes

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route" "private_route" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ngw.id
}

resource "aws_route" "database_route" {
  route_table_id            = aws_route_table.database_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ngw.id
}

# Subnet Association ------------------------------------------------
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
  # Here we are assigning the public route table to public subnets (we have 2 subnets so we are looping with count)
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnets_cidr)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database_rt.id
}