resource "aws_ecs_cluster" "this" {
  count = var.create_ecs ? 1 : 0

  name = var.name

  capacity_providers = var.capacity_providers != [] && var.enable_spot ?  ["FARGATE_SPOT"] : ["FARGATE"]

  dynamic "default_capacity_provider_strategy" {
    for_each = length(keys(var.default_capacity_provider_strategy)) == 0 ? [] : [var.default_capacity_provider_strategy]
    iterator = strategy

    content {
      capacity_provider = strategy.value["capacity_provider"]
      weight            = lookup(strategy.value, "weight", null)
      base              = lookup(strategy.value, "base", null)
    }
  }

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = var.tags
}



resource "aws_ecs_task_definition" "this" {
  count = var.create_ecs ? 1 : 0

  family = var.task_name
  network_mode = var.network_mode
  requires_compatibilities = var.requires_compatibilities

  task_role_arn = aws_iam_role.this.arn
  execution_role_arn = aws_iam_role.this.arn

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
    "name": "${var.task_name}",
    "image": "${var.image_name}",
    "logConfiguration": {
      "logDriver": "${var.log_driver}",
      "options": {
        "awslogs-region": "eu-west-1",
        "awslogs-group": "/aws/ecs/tasks/${var.task_name}",
        "awslogs-stream-prefix": "${var.task_name}"
      }
    }
  }
]
EOF

  tags = var.tags
}

resource "aws_ecs_service" "this" {
  count = var.create_ecs ? 1 : 0

  name            = var.task_name
  cluster         = aws_ecs_cluster.this[count.index].id
  task_definition = aws_ecs_task_definition.this[count.index].arn

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  network_configuration {
    subnets = var.subnets
    security_groups = var.security_groups
    assign_public_ip = var.assign_public_ip
  }
}
