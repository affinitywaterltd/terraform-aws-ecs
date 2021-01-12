resource "aws_iam_role_policy_attachment" "this_custom" {
  count = var.create_iam_role ? length(var.task_names) : 0

  role       = var.iam_role
  policy_arn = element(var.iam_policies, count.index)
}