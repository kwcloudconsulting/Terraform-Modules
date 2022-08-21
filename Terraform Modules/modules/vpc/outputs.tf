output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.TerraformCloudChallenge.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_app_1_id" {
  value = aws_subnet.private_subnet_app_1.id
}

output "private_subnet_app_2_id" {
  value = aws_subnet.private_subnet_app_2.id
}

output "private_subnet_data_1_id" {
  value = aws_subnet.private_subnet_data_1.id
}

output "private_subnet_data_2_id" {
  value = aws_subnet.private_subnet_data_2.id
}

output "internet_gateway" {
  value = aws_internet_gateway.TerraformCloud_internet_gateway.id
}
  
