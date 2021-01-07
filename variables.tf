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

variable "requires_compatibilities" {
  description = "A set of launch types required by the task. The valid values are EC2 and FARGATE"
  type        = list(string)
  default     = ["FARGATE"]
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

variable "network_mode" {
  description = "Log Stream prefic used for logging to CloudWatch"
  type        = string
  default     = "awsvpc"
}

variable "dnsSearchDomains" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
}

variable "environmentFiles" {
  description = "Set value within containerDefinitions"
  type        = string
  default     = "null"
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
  default     = "null"
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



#####
## ECS Service
#####
variable "subnets" {
  description = "The subnets associated with the task or service"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false."
  type        = string
  default     = false
}

variable "launch_type" {
  description = "The launch type on which to run your service. The valid values are EC2 and FARGATE. Defaults to EC2."
  type        = string
  default     = "FARGATE"
}