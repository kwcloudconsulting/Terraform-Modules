# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet 1
resource "aws_eip" "eip_for_nat_gateway_public_subnet_1" {
  vpc    = true

  tags   = {
    Name = "nat gateway eip for public subnet 1"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet 2
resource "aws_eip" "eip_for_nat_gateway_public_subnet_2" {
  vpc    = true

  tags   = {
    Name = "nat gateway eip for public subnet 2"
  }
}

# create nat gateway in public subnet 1 and associate it with the elastic ip
resource "aws_nat_gateway" "nat_gateway_public_subnet_1" {
  allocation_id = aws_eip.eip_for_nat_gateway_public_subnet_1.id
  subnet_id     = var.public_subnet_1_id

  tags   = {
    Name = "nat gateway in public subnet 1"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.internet_gateway]
}

# create nat gateway in public subnet 2 and associate it with the elastic ip
resource "aws_nat_gateway" "nat_gateway_public_subnet_2" {
  allocation_id = aws_eip.eip_for_nat_gateway_public_subnet_2.id
  subnet_id     = var.public_subnet_2_id

  tags   = {
    Name = "nat gateway in public subnet 2"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the internet gateway for the vpc.
  depends_on = [var.internet_gateway]
}

# create private route table 1 and add route through nat gateway 1
resource "aws_route_table" "private_route_table_private_subnet_1" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_public_subnet_1.id
  }

  tags   = {
    Name = "private route table 1"
  }
}

# associate private subnet app 1 with private route table 1
resource "aws_route_table_association" "private_subnet_app_1_route_table_az1_association" {
  subnet_id         = var.private_subnet_app_1_id
  route_table_id    = aws_route_table.private_route_table_private_subnet_1.id


}

# associate private subnet data 1 with private route table 1
resource "aws_route_table_association" "private_subnet_data_1_route_table_az1_association" {
  subnet_id         = var.private_subnet_data_1_id
  route_table_id    = aws_route_table.private_route_table_private_subnet_1.id
}

# create private route table 2 and add route through nat gateway 2
resource "aws_route_table" "private_route_table_private_subnet_2" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_public_subnet_2.id
    }
    tags   = {
      Name = "private route table 2"
    }

    depends_on = [aws_nat_gateway.nat_gateway_public_subnet_2]
}

# associate private subnet app 2 with private route table 2
resource "aws_route_table_association" "private_subnet_app_2_route_table_az2_association" {
  subnet_id         = var.private_subnet_app_2_id
  route_table_id    = aws_route_table.private_route_table_private_subnet_2.id
}

# associate private subnet data 2 with private route table 2
resource "aws_route_table_association" "private_subnet_data_2_route_table_az2_association" {
  subnet_id         = var.private_subnet_data_2_id
  route_table_id    = aws_route_table.private_route_table_private_subnet_2.id
}