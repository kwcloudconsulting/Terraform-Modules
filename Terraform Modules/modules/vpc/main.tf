# Create VPC
# terraform aws create vpc
resource "aws_vpc" "TerraformCloudChallenge" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support      = true

  tags      = {
    Name    = "${var.project_name}_vpc"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "TerraformCloud_internet_gateway" {
  vpc_id    = aws_vpc.TerraformCloudChallenge.id

  tags      = {
    Name    = "${var.project_name}_internet_gateway"
  }
}

# use data source to set all availability zones in region
data "aws_availability_zones" "availability_zones" {
  
}
# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.TerraformCloudChallenge.id
  cidr_block              = "${var.public_subnet_1_cidr}"
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "${var.project_name}_public_subnet_1"
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.TerraformCloudChallenge.id
  cidr_block              = "${var.public_subnet_2_cidr}"
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "${var.project_name}_public_subnet_2"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.TerraformCloudChallenge.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TerraformCloud_internet_gateway.id
  }

  tags       = {
    Name     = "${var.project_name}_public_route_table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet_1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet_2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# Create Private Subnet app 1
# terraform aws create subnet
resource "aws_subnet" "private_subnet_app_1" {
  vpc_id                   = aws_vpc.TerraformCloudChallenge.id
  cidr_block               = "${var.private_subnet_app_1_cidr}"
  availability_zone        = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "${var.project_name}_private_subnet_app_1"
  }
}

# Create Private Subnet app 2
# terraform aws create subnet
resource "aws_subnet" "private_subnet_app_2" {
  vpc_id                   = aws_vpc.TerraformCloudChallenge.id
  cidr_block               = "${var.private_subnet_app_2_cidr}"
  availability_zone        = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "${var.project_name}_private_subnet_app_2"
  }
}

# Create Private Subnet data 1
# terraform aws create subnet
resource "aws_subnet" "private_subnet_data_1" {
  vpc_id                   = aws_vpc.TerraformCloudChallenge.id
  cidr_block               = "${var.private_subnet_data_1_cidr}"
  availability_zone        = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "${var.project_name}_private_subnet_data_1"
  }
}

# Create Private Subnet data 2
# terraform aws create subnet
resource "aws_subnet" "private_subnet_data_2" {
  vpc_id                   = aws_vpc.TerraformCloudChallenge.id
  cidr_block               = "${var.private_subnet_data_2_cidr}"
  availability_zone        = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "${var.project_name}_private_subnet_data-2"
  }
}