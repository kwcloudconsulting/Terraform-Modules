# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name               = var.application_load_balancer
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection = false

  tags   = {
    Name = "Application Load Balancer"
  }
}

# create target group
resource "aws_lb_target_group" "application_load_balancer_target_group" {
  name        = var.application_load_balancer_target_group
  target_type = "alb"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  
  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "application_load_balancer_http_listener_port_80" {
  load_balancer_arn = var.application_load_balancer.arn
  port              = 80    
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# create a listener on port 443 with forward action
resource "aws_lb_listener" "application_load_balancer_https_listener_port_443" {
  load_balancer_arn  = var.application_load_balancer_arn
  port               = 443  
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = "var.certificate_arn"

  default_action {
    type             = forward
    target_group_arn = var.application_load_balancer_target_group.arn
  }
}