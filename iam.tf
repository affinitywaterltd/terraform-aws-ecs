resource "aws_iam_role" "this" {
  count = var.create_iam_role ? length(var.task_names) : 0

  name = "ecs_task_role_${var.task_names[count.index]}-${var.environment_name}"
  description = "IAM role applied to ECS Task - ${var.task_names[count.index]}-${var.environment_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {

      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [ "ecs-tasks.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.create_iam_role ? length(var.task_names) : 0

  role       = aws_iam_role.this[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "custom_iam_policy_attachments" {
  count = var.create_iam_role ? length(var.task_names) : 0

  source = "./iam"

  iam_role         = aws_iam_role.this[count.index].name
  iam_policies = var.task_assigned_iam_policies[count.index]
}