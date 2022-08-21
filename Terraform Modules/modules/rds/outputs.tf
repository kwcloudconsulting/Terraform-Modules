output "db_subnet_group" {
  value = aws_db_subnet_group.subnet_group_aurora.id
}

output "db_instance_class" {
  value = aws_rds_cluster_instance.rds_db_instance.instance_class
}

output "db_password" {
  value = aws_rds_cluster.rds_cluster.master_password
}

output "db_name" {
  value = aws_rds_cluster.rds_cluster.database_name

}

output "db_username" {
  value = aws_rds_cluster.rds_cluster.master_username
}
