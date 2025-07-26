### VPC Module 

This module creates following resources, we are using Hoigh Availability 
* VPC
* Internet gateway with VPC association
* 2 Public subnets az-1a and az-1b
* 2 Private subnets in az-1a and az-1b
* 2 database subnets in az-1a and az-1b
* Elastic IP
* NAT gateway in az-1a public subnet
* Public route table
* Private route table
* Database route table
* Routes association to route table's
* Route table's association to Subnet's
* VPC Peering if user requests
* Adding the peering route in the defaule route table of default VPC if user didn't provide the acceptor VPC ID explecitely
* Adding the peering route in the route tables (public, private and database) of Roboshop VPC


### Inputs 

* project_name (required): your project name
* environment (required): your environment
* vpc_cidr (optional): default value is "10.0.0.0/16", User can override
* common_tags (optional): Better to provide 
* vpc_tags (optional)
* igw_tags (optional)
* public_subnets cidr (required): User must provide two valid public subnets cidr
* public_subnets_tags (optiona)
* private_subnets cidr (required): User must provide two valid private subnets cidr
* private_subnets_tags (optiona)
* database_subnets cidr (required): User must provide two valid database subnets cidr
* database_subnets_tags (optiona)
* ngw_tags (optional)
* public_rt_tags (optional)
* private_rt_tags (optional)
* database_rt_tags (optional)
* is_peering_required (optiona): default value is "flase", User can override
* acceptor_vpc_id (optional): default value is empty/default VPC ID, but user needs to provide if he/she needs peering to other than default VPC.
* vpc_peering_tags (optional)


### Outputs

* vpc_id: ID created VPC
* public_subnet_ids: 2 public subnet IDs created
* private_subnet_ids: 2 private subnet IDs created
* database_subnet_ids: 2 database subnet IDs created



