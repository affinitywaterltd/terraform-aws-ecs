data "aws_subnet" "this" {
  id = var.subnets[0]
}

resource "aws_lb_target_group" "this" {
  count = var.create_lb_target_group ? 1 : 0
  name     = var.task_name
  port     = 5000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = data.aws_subnet.this.vpc_id

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 7200
    enabled         = true
  }

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = 5000
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
  }
}