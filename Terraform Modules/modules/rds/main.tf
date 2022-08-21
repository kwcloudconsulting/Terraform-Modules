# create database subnet group
# terraform aws create db subnet group


resource "aws_db_parameter_group" "parameter_group_mysql" {
  name        = "parametergrouppostgres"
  family      = "postgres13" // ??
  description = "Postgres parameter group for ${var.project_name}"
  
}

resource "aws_db_subnet_group" "subnet_group_aurora" {
  name        = "subnet group aurora"
  description = "Subnet group for ${var.project_name}"
  subnet_ids  = [ var.private_subnet_data_1_id, var.private_subnet_data_2_id ]

}

# create database instance
# terraform aws create db instance

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier = "cloudchallenge-db"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "13.6"
  database_name      = var.db_name
  master_username    = var.db_username
  master_password    = var.db_password

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "rds_db_instance" {

  cluster_identifier = aws_rds_cluster.rds_cluster.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.rds_cluster.engine
  engine_version     = aws_rds_cluster.rds_cluster.engine_version
 
    
}