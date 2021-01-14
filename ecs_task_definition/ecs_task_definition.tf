
resource "aws_ecs_task_definition" "this" {
  family = var.family
  network_mode = var.network_mode
  requires_compatibilities = var.requires_compatibilities

  task_role_arn = var.task_role_arn
  execution_role_arn = var.execution_role_arn

  cpu = var.task_cpu
  memory = var.task_memory
  container_definitions = <<EOF
[
  {
    "cpu": ${var.task_cpu},
    "memory": ${var.task_memory},
    "dnsSearchDomains": ${var.dnsSearchDomains},
    "environmentFiles": ${var.environmentFiles},
    "secretOptions": ${var.secretOptions},
    "entryPoint": ${var.entryPoint},
    "portMappings": ${var.portMappings},
    "command": ${var.command},
    "linuxParameters": ${var.linuxParameters},
    "environment": ${var.environment},
    "resourceRequirements": ${var.resourceRequirements},
    "ulimits": ${var.ulimits},
    "dnsServers": ${var.dnsServers},
    "mountPoints": ${var.mountPoints},
    "workingDirectory": ${var.workingDirectory},
    "secrets": ${var.secrets},
    "dockerSecurityOptions": ${var.dockerSecurityOptions},
    "volumesFrom": ${var.volumesFrom},
    "stopTimeout": ${var.stopTimeout},
    "startTimeout": ${var.startTimeout},
    "name": "${var.task_names[count.index]}-${var.environment_name}",
    "image": "${length(var.custom_image_names) > 0 ? var.custom_image_names[count.index] : aws_ecr_repository.this[count.index].repository_url}",
    "logConfiguration": {
      "logDriver": "${var.log_driver}",
      "options": {
        "awslogs-region": "${var.aws_region},
        "awslogs-group": "/aws/ecs/cluster/${aws_ecs_cluster.this[0].name}",
        "awslogs-stream-prefix": "${var.task_names[count.index]}/${var.environment_name}}/"
      }
    }
  }
]
EOF

  tags = var.tags
}