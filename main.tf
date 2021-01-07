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
  family = var.task_name
  network_mode = var.network_mode

  cpu = var.task_cpu
  memory = var.memory
  container_definitions = <<EOF
[
  {
    "name": "${var.task_name}",
    "image": "${var.image_name}"
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