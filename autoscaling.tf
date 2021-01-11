
resource "aws_appautoscaling_target" "ecs_target" {
  count = var.enable_autoscaling ? length(var.task_names) : 0
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${aws_ecs_cluster.this[0].name}/${aws_ecs_service.this[0].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  count = var.enable_autoscaling && var.enable_autoscaling_cpu ? length(var.task_names) : 0
  name               = "auto-scaling-tracking-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration  {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = var.autoscaling_target_value_cpu
    scale_in_cooldown = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  count = var.enable_autoscaling && var.enable_autoscaling_memory ? length(var.task_names) : 0
  name               = "auto-scaling-tracking-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration  {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = var.autoscaling_target_value_cpu
    scale_in_cooldown = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}