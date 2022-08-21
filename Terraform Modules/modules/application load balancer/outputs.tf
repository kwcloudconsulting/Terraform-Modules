output "application_load_balancer" {
  value = aws_lb.application_load_balancer.id
}

output "application_load_balancer_target_group" {
  value = aws_lb_target_group.alb_target_group.id
}

output "application_load_balancer_listener_port_80" {
  value = aws_lb_listener.alb_http_listener_port_80.id

}

output "application_load_balancer_listener_port_443" {
  value = aws_lb_listener.alb_https_listener_port_443.id
}

