output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = concat(aws_ecs_cluster.this.*.id, [""])[0]
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = concat(aws_ecs_cluster.this.*.arn, [""])[0]
}

output "ecs_service_ids" {
  description = "IDs of the ECS Services"
  value       = concat(aws_ecs_service.this.*.id, [""])
}

output "ecs_task_definition_families" {
  description = "Familites of the ECS Task Definitiopns"
  value       = concat(module.aws_ecs_task_definition.*.ecs_task_definition_family, [""])
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = var.name
}

output "lb_target_group_arns" {
  description = "ARN of the LB Target Group"
  value       = concat(aws_lb_target_group.this.*.arn, [""])
}

output "iam_ecs_task_roles" {
  description = "ARN of the IAM Roles used by ECS"
  value       = concat(aws_iam_role.this.*.arn, [""])
}