
resource "aws_appautoscaling_target" "ecs_target" {
  count = var.enable_autoscaling ? length(var.task_names) : 0

  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${aws_ecs_cluster.this[0].name}/${aws_ecs_service.this[count.index].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  lifecycle {
    ignore_changes = [max_capacity, min_capacity]
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  count = var.enable_autoscaling && var.enable_autoscaling_cpu ? length(var.task_names) : 0

  name               = "auto-scaling-tracking-${aws_ecs_service.this[count.index].name}-cpu"
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

  name               = "ecs-auto-scaling-tracking-${aws_ecs_service.this[count.index].name}-memory"
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

resource "aws_appautoscaling_scheduled_action" "ecs_policy_scheduled_0" {
  count = var.enable_autoscaling && length(var.autoscaling_scheduled_actions) >= 1 ? length(var.task_names) : 0

  name               = "ecs-auto-scaling-scheduled-${aws_ecs_service.this[count.index].name}-0"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace
  schedule           = lookup(var.autoscaling_scheduled_actions[0],"schedule", null)

  scalable_target_action   {
    min_capacity  = lookup(var.autoscaling_scheduled_actions[0],"min_capacity", 0)
    max_capacity  = lookup(var.autoscaling_scheduled_actions[0],"max_capacity", 0)
  }
}

resource "aws_appautoscaling_scheduled_action" "ecs_policy_scheduled_1" {
  count = var.enable_autoscaling && length(var.autoscaling_scheduled_actions) >= 2 ? length(var.task_names) : 0

  name               = "ecs-auto-scaling-scheduled-${aws_ecs_service.this[count.index].name}-1"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace
  schedule           = lookup(var.autoscaling_scheduled_actions[1],"schedule", null)

  scalable_target_action   {
    min_capacity  = lookup(var.autoscaling_scheduled_actions[1],"min_capacity", 0)
    max_capacity  = lookup(var.autoscaling_scheduled_actions[1],"max_capacity", 0)
  }
}

resource "aws_appautoscaling_scheduled_action" "ecs_policy_scheduled_2" {
  count = var.enable_autoscaling && length(var.autoscaling_scheduled_actions) >= 3 ? length(var.task_names) : 0

  name               = "ecs-auto-scaling-scheduled-${aws_ecs_service.this[count.index].name}-2"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace
  schedule           = lookup(var.autoscaling_scheduled_actions[2],"schedule", null)

  scalable_target_action   {
    min_capacity  = lookup(var.autoscaling_scheduled_actions[2],"min_capacity", 0)
    max_capacity  = lookup(var.autoscaling_scheduled_actions[2],"max_capacity", 0)
  }
}

resource "aws_appautoscaling_scheduled_action" "ecs_policy_scheduled_3" {
  count = var.enable_autoscaling && length(var.autoscaling_scheduled_actions) >= 4 ? length(var.task_names) : 0

  name               = "ecs-auto-scaling-scheduled-${aws_ecs_service.this[count.index].name}-3"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace
  schedule           = lookup(var.autoscaling_scheduled_actions[3],"schedule", null)

  scalable_target_action   {
    min_capacity  = lookup(var.autoscaling_scheduled_actions[3],"min_capacity", 0)
    max_capacity  = lookup(var.autoscaling_scheduled_actions[3],"max_capacity", 0)
  }
}