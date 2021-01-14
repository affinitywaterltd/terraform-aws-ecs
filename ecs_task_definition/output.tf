output "ecs_task_definition_arns" {
  description = "The ARNs of the task definitions"
  value       = concat(aws_ecs_task_definition.this.*.arn, [""])
}