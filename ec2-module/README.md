### EC2-Module

#### Inputs
* ami_id (Optional): AMI ID is optional, default AMI ID is "ami-09c813fb71547fc4f" which is RHEL-9.
* instance_type (Optional): Default instance_type is "t2.micro".
* tags (Optional): default value is empty.

#### Outputs
* public_ip: Public IP of the instance.
* private_ip: Private IP of the instance.
* instance_id: Instance ID