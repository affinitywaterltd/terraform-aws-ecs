variable "iam_policies" {
  description = "Attach IAM roles to each configured task"
  type        = list(string)
  default     = []
}

variable "iam_role" {
  description = "IAM role to attach policies to"
  type        = string
  default     = null
}