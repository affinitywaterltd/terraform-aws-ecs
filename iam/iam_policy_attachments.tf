resource "aws_iam_role_policy_attachment" "this_custom" {
  count = length(var.iam_policies) > 0 ? length(var.iam_policies) : 0

  role       = var.iam_role
  policy_arn = element(var.iam_policies, count.index)
}