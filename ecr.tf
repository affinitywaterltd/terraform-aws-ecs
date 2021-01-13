resource "aws_ecr_repository" "this" {
  count = var.create_ecs ? length(var.task_names) : 0

  name                 = lookup(var.task_names, count.index)
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}