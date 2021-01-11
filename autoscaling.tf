
resource "aws_appautoscaling_target" "ecs_target" {
  count = var.enable_autoscaling ? 1 : 0
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${var.task_name}-${var.environment_name}/${var.task_name}-${var.environment_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  count = var.enable_autoscaling ? 1 : 0
  name               = "auto-scaling-tracking-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration  {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 70
    scale_in_cooldown = 120
    scale_out_cooldown = 120
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  count = var.enable_autoscaling ? 1 : 0
  name               = "auto-scaling-tracking-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration  {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = 70
    scale_in_cooldown = 120
    scale_out_cooldown = 120
  }
}