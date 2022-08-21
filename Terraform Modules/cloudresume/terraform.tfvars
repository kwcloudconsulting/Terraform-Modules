region                     = "us-east-1"
project_name               = "TerraformCloudProject"
vpc_id                     = "aws_vpc_TerraformCloudChallenge"
vpc_cidr                   = "10.0.0.0/16"
public_subnet_1_cidr       = "10.0.0.0/24"
public_subnet_2_cidr       = "10.0.1.0/24"
private_subnet_app_1_cidr  = "10.0.2.0/24"
private_subnet_app_2_cidr  = "10.0.3.0/24"
private_subnet_data_1_cidr = "10.0.4.0/24"
private_subnet_data_2_cidr = "10.0.5.0/24"
db_instance_class          = "db.t2.small"
#db_instance_identifier     = "TerraformCloudChallenge"
db_username = "TerraformCloudChallenge"
db_password = "TerraformCloudChallengepassword"
db_name     = "TerraformCloudChallenge"
multi_az    = false
