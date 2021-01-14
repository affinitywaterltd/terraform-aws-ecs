output "ecs_task_definition_arns" {
  description = "The ARNs of the task definitions"
  value       = aws_ecs_task_definition.this.*.arn
}