variable "awslogs-region" {
  description = "Region resources are deployed in"
  type        = string
  default     = "eu-west-1"
}

#####
## ECS Task Definition
#####
variable "family" {
  description = "(Required) A unique name for your task definition."
  type        = string
  default     = null
}

variable "requires_compatibilities" {
  description = "(Optional) A set of launch types required by the task. The valid values are EC2 and FARGATE."
  type        = list(string)
  default     = ["FARGATE"]
}

variable "task_role_arn" {
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  type        = string
  default     = null
}

variable "execution_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
  type        = string
  default     = null
}

variable "logDriver" {
  description = "By default, containers use the same logging driver that the Docker daemon uses. However the container may use a different logging driver than the Docker daemon by specifying a log driver with this parameter in the container definition"
  type        = string
  default     = "awslogs"
}

variable "awslogs-group" {
  description = "Log Group name used for awslogs deamon"
  type        = string
  default     = "null"
}

variable "awslogs-stream-prefix" {
  description = "Prefix used for log streams"
  type        = string
  default     = "null"
}


variable "task_name" {
  description = "Names to be used for the ECS Task Definition"
  type        = string
  default     = "null"
}

variable "cpu" {
  description = "The vCPU specification for the ECS Task Definition"
  type        = string
  default     = 256
}

variable "memory" {
  description = "The memory specification for the ECS Task Definition"
  type        = string
  default     = 512
}

variable "task_cpu" {
  description = "The vCPU specification for the ECS Task Definition"
  type        = string
  default     = 256
}

variable "task_memory" {
  description = "The memory specification for the ECS Task Definition"
  type        = string
  default     = 512
}

variable "image_name" {
  description = "Name of the image to be used for the ECS Task Definition"
  type        = string
  default     = "null"
}

variable "image_tag" {
  description = "Name of the image tag to be used for the ECS Task Definition"
  type        = string
  default     = "latest"
}


variable "default_image_tags" {
  description = "Name of the default image tag to be used for the ECS Task Definition"
  type        = string
  default     = "latest"
}

variable "log_driver" {
  description = "Task log driver (Default: awslogs)"
  type        = string
  default     = "awslogs"
}

variable "log_stream_prefix" {
  description = "Log Stream prefic used for logging to CloudWatch"
  type        = string
  default     = ""
}

variable "network_mode" {
  description = "Log Stream prefic used for logging to CloudWatch"
  type        = string
  default     = "awsvpc"
}

variable "dnsSearchDomains" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "[]"
}

variable "environmentFiles" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "[]"
}

variable "secretOptions" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "entryPoint" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "portMappings" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "[]"
}

variable "command" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "linuxParameters" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "environment" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "[]"
}

variable "resourceRequirements" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "ulimits" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "dnsServers" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "mountPoints" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "[]"
}

variable "workingDirectory" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "secrets" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "[]"
}

variable "dockerSecurityOptions" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "volumesFrom" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "[]"
}

variable "stopTimeout" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "startTimeout" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "tags" {
  description = "A map of tags to add to ECS Task Definition"
  type        = map(string)
  default     = {}
}