output "ecs_task_definition_arn" {
  description = "The ARNs of the task definitions"
  value       = aws_ecs_task_definition.this.arn
}

output "ecs_task_definition_family" {
  description = "The families of the task definitions"
  value       = aws_ecs_task_definition.this.family
}