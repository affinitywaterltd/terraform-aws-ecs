data "aws_subnet" "this" {
  id = var.subnets[0]
}

resource "aws_lb_target_group" "this" {
  count = var.create_lb_target_group ? length(var.task_names) : 0
  name     = "${var.task_names[count.index]}-${var.environment_name}"
  port     = var.container_port
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
    port                = var.container_port
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
  }
}