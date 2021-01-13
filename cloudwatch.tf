resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/cluster/${aws_ecs_cluster.this[0].name}"
  retention_in_days = var.cloudwatch_retention_in_days

  tags = var.tags
}