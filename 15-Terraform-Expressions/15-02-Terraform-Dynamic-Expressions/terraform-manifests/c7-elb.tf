# AWS ELB

resource "aws_elb" "elb" {
  name    = join("",["tf-elb-", "${terraform.workspace}"])
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  # Splat Expression
  instances                   = aws_instance.my-ec2-vm[*].id

  # Dynamic Expressions
  count = (var.high_availability == true ? 1 : 0)
  # availability_zones = var.availability_zones
  subnets = local.subnet_ids
  security_groups = [aws_security_group.vpc-tf-elb[count.index].id]
  tags = local.common_tags
}



