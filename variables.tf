variable "create_ecs" {
  description = "Controls if ECS should be created"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier, also the name of the ECS cluster"
  type        = string
  default     = null
}

variable "enable_spot" {
  description = "Controls if capacity Provider includes SPOT instances"
  type        = bool
  default     = true
}

variable "capacity_providers" {
  description = "List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT."
  type        = list(string)
  default     = []
}

variable "default_capacity_provider_strategy" {
  description = "The capacity provider strategy to use by default for the cluster. Can be one or more."
  type        = map(any)
  default     = {}
}

variable "container_insights" {
  description = "Controls if ECS Cluster has container insights enabled"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to ECS Cluster"
  type        = map(string)
  default     = {}
}


#####
## ECS Task Definition
#####
variable "task_name" {
  description = "Name to be used for the ECS Task Definition"
  type        = string
  default     = null
}

variable "task_cpu" {
  description = "The vCPU specification for the ECS Task Definition"
  type        = string
  default     = 0
}

variable "task_memory" {
  description = "The memory specification for the ECS Task Definition"
  type        = string
  default     = 128
}

variable "image_name" {
  description = "Name of the image to be used for the ECS Task Definition"
  type        = string
  default     = null
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