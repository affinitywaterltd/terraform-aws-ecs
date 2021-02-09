data "aws_subnet" "this" {
  id = var.subnets[0]
}

resource "aws_lb_target_group" "this" {
  count = var.create_lb_target_group ? length(var.task_names) : 0
  name     = "${var.task_names[count.index]}-${var.environment_name}"
  port     = var.container_port
  protocol = var.protocol
  target_type = var.target_type
  vpc_id   = data.aws_subnet.this.vpc_id

  deregistration_delay = var.deregistration_delay
  
  stickiness {
    type            = var.stickiness_type
    cookie_duration = var.stickiness_cookie_duration
    enabled         = var.stickiness_enabled
  }

  health_check {
    path                = var.healthcheck_path[count.index]
    protocol            = var.healthcheck_protocol
    port                = var.container_port
    healthy_threshold   = var.healthcheck_healthy_threshold
    unhealthy_threshold = var.healthcheck_unhealthy_threshold
    interval            = var.healthcheck_interval
  }

  tags = var.tags
}