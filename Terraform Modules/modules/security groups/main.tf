# create security group for application load balancer
resource "aws_security_group" "alb_security_group" {
  name = "alb_security_group"
  description = "enable http/https access on port 80 and 443 to alb"
    vpc_id = var.vpc_id

    ingress {
        description = "http access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
        description = "https access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]


    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }


}

    # create security group for container
    resource "aws_security_group" "ecs_security_group" {
        name = "ecs securiry group"
        description = "enable http/https access on port 80 and 443 to ecs"
        vpc_id = var.vpc_id
    

        ingress {
            description = "http access"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            security_groups = [aws_security_group.alb_security_group.id]

        }

        ingress {
            description = "https access"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            security_groups = [aws_security_group.alb_security_group.id]

        }

        egress {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]

        }
    }