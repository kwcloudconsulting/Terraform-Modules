output "efs_file_system" {
  value = aws_efs_file_system.wordpress_persistent.id
}

output "iam_policy" {
  value = aws_iam_policy.wordpress_bucket_access.arn

}  

output "aws_iam_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.wordpress_bucket_access.id

}

output "aws_iam_role" {
  value = aws_iam_role.wordpress_task.id

}

output "aws_iam_role_policy_attachment_ecs" {
  value = aws_iam_role_policy_attachment.wordpress_role_attachment_ecs.id

}
output "aws_iam_role_policy_attachment_cloudwatch" {
  value = aws_iam_role_policy_attachment.wordpress_role_attachment_cloudwatch.id

}
output "aws_efs_access_point" {
  value = aws_efs_access_point.wordpress_efs.id

  
}
output "aws_security_group" {
  value = aws_security_group.efs_security_group.id
}

output "aws_security_group_rule" {
  value = aws_security_group_rule.efs_ingress.id
}
output "aws_efs_mount_target" {
  value = aws_efs_mount_target.wordpress_efs.id
}
output "aws_cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.wordpress_container.id
}

output "aws_ecs_task_definition" {
  value = aws_ecs_task_definition.wordpress_container.id
}

output "aws_security_group" {
    value = aws_security_group.wordpress_security_group.id

}
output "aws_security_group_rule" {
    value = aws_security_group_rule.wordpress_sg_ingress_80.id
}
output "aws_security_group_rule" {
    value = aws_security_group_rule.wordpress_sg_egress_2049.id

}
output "aws_security_group_rule" {
    value = aws_security_group_rule.wordpress_sg_egress_80.id
}
output "aws_security_group_rule" {
    value = aws_security_group_rule.wordpress_sg_egress_443.id
}
output "aws_security_group_rule" {
    value = aws_security_group_rule.wordpress_sg_egress_3306.id
}
output "aws_ecs_service" {
    value = aws_ecs_service.wordpress_service.id
}

output "aws_ecs_cluster" {
    value = aws_ecs_cluster.wordpress_cluster.id
}

