resource "aws_ecs_cluster" "this" {
  count = var.create_ecs ? 1 : 0

  name = "${var.name}-${var.environment_name}"

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
  count = var.create_ecs ? length(var.task_names) : 0

  family = "${var.task_names[count.index]}-${var.environment_name}"
  network_mode = var.network_mode
  requires_compatibilities = var.requires_compatibilities

  task_role_arn = var.create_iam_role ? aws_iam_role.this[count.index].arn : var.iam_role
  execution_role_arn = var.create_iam_role ? aws_iam_role.this[count.index].arn : var.iam_role

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
    "image": "${var.image_names[count.index]}",
    "logConfiguration": {
      "logDriver": "${var.log_driver}",
      "options": {
        "awslogs-region": "eu-west-1",
        "awslogs-group": "/aws/ecs/cluster/${aws_ecs_cluster.this[0].name}",
        "awslogs-stream-prefix": "${var.task_names[count.index]}/${var.environment_name}}/"
      }
    }
  }
]
EOF

  tags = var.tags
}

resource "aws_ecs_service" "this" {
  count = var.create_ecs ? length(var.task_names) : 0

  name            = "${var.task_names[count.index]}-${var.environment_name}"
  cluster         = aws_ecs_cluster.this[0].id
  task_definition = aws_ecs_task_definition.this[count.index].arn
  launch_type     = var.launch_type

  desired_count = var.desired_count

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  force_new_deployment = var.force_new_deployment

  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  platform_version = var.platform_version

  network_configuration {
    subnets = var.subnets
    security_groups = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this[count.index].arn
    container_name = "${var.task_names[count.index]}-${var.environment_name}"
    container_port = var.container_port
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
}
