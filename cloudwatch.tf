resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/tasks/${var.task_name}-${var.environment_name}"
  retention_in_days = var.cloudwatch_retention_in_days
}