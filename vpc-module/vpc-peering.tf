resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_required ? 1 : 0
  peer_vpc_id   = var.acceptor_vpc_id == "" ? data.aws_vpc.default_vpc.id : var.acceptor_vpc_id # Accepter VPC ID
  vpc_id        = aws_vpc.vpc_module.id # Requester VPC ID : Roboshop-VPC
  auto_accept = var.acceptor_vpc_id == "" ? true : false 

  tags = merge(var.common_tags, var.vpc_peering_tags,
  {
        Name = "${var.project_name}-default-pcx"
  }
  )
}

# Adding Peering Routes
# Here we are adding peering route to Default Route table in Default VPC from Roboshop VPC

resource "aws_route" "acceptor_peering" {
  count = var.is_peering_required && var.acceptor_vpc_id == "" ? 1 : 0 # if peering is required and user did not provide any accetor vpc ID then 
  route_table_id            = data.aws_route_table.default_rt.id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id 
}

# Here we are adding peering route to Route tables in Roboshop VPC ----------------------

resource "aws_route" "public_peering" {
  count = var.is_peering_required && var.acceptor_vpc_id == "" ? 1 : 0 # if peering is required and user did not provide any accetor vpc ID then 
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id 
}


resource "aws_route" "private_peering" {
  count = var.is_peering_required && var.acceptor_vpc_id == "" ? 1 : 0 # if peering is required and user did not provide any accetor vpc ID then 
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id 
}

resource "aws_route" "database_peering" {
  count = var.is_peering_required && var.acceptor_vpc_id == "" ? 1 : 0 # if peering is required and user did not provide any accetor vpc ID then 
  route_table_id            = aws_route_table.database_rt.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id 
}
