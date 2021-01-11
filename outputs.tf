output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = concat(aws_ecs_cluster.this.*.id, [""])[0]
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = concat(aws_ecs_cluster.this.*.arn, [""])[0]
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = var.name
}


output "lb_target_group_arns" {
  description = "ARN of the LB Target Group"
  value       = concat(aws_lb_target_group.this.*.arn, [""])
}