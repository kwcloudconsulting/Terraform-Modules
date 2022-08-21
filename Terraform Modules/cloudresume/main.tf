# configure aws provider
provider "aws" {
  region = var.region

}

# create vpc
module "vpc" {
  source                     = "../modules/vpc"
  region                     = var.region
  vpc_id                     = var.vpc_id
  project_name               = var.project_name
  vpc_cidr                   = var.vpc_cidr
  public_subnet_1_cidr       = var.public_subnet_1_cidr
  public_subnet_2_cidr       = var.public_subnet_2_cidr
  private_subnet_app_1_cidr  = var.private_subnet_app_1_cidr
  private_subnet_app_2_cidr  = var.private_subnet_app_2_cidr
  private_subnet_data_1_cidr = var.private_subnet_data_1_cidr
  private_subnet_data_2_cidr = var.private_subnet_data_2_cidr


}
# create nat gateways
module "nat_gateway" {
  source                   = "../modules/nat gateway"
  public_subnet_1_id       = module.vpc.public_subnet_1_id
  internet_gateway         = module.vpc.internet_gateway
  public_subnet_2_id       = module.vpc.public_subnet_2_id
  vpc_id                   = module.vpc.vpc_id
  private_subnet_app_1_id  = module.vpc.private_subnet_app_1_id
  private_subnet_data_1_id = module.vpc.private_subnet_data_1_id
  private_subnet_app_2_id  = module.vpc.private_subnet_app_2_id
  private_subnet_data_2_id = module.vpc.private_subnet_data_2_id

}

# create security groups
module "security_group" {
  source = "../modules/security groups"
  vpc_id = module.vpc.vpc_id

}

# create rds database
module "rds_database" {
  source            = "../modules/rds"
  db_instance_class = var.db_instance_class
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  ##multi_az                 = var.multi_az
  private_subnet_data_1_id = module.vpc.private_subnet_data_1_id
  private_subnet_data_2_id = module.vpc.private_subnet_data_2_id
  vpc_id                   = module.vpc.vpc_id
  project_name             = module.vpc.project_name
}

# create alb


  