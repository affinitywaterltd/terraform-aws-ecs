data "aws_region" "current" {}

variable "terraform_match_task_definition_service" {
  description = "Custom scheduled scaling actions"
  type        = bool
  default     = false
}

variable "create_ecs" {
  description = "Controls if ECS should be created"
  type        = bool
  default     = true
}

variable "create_ecr" {
  description = "Controls if ECR should be created"
  type        = bool
  default     = true
}

variable "ecr_cross_account_princpals" {
  description = "Used to define the ECR Permissions Policy - Controls which other accounts might be given access to the ECR repo"
  type        = string
  default     = "[]"
}

variable "name" {
  description = "Name to be used on all the resources as identifier, also the name of the ECS cluster"
  type        = string
  default     = null
}

variable "environment_name" {
  description = "Name of the environment (e.g. dev, demo, prod)"
  type        = string
  default     = null
}

variable "enable_spot" {
  description = "Controls if capacity Provider includes SPOT instances"
  type        = bool
  default     = true
}

variable "enable_autoscaling" {
  description = "Controls if an app autoscaling policy is created"
  type        = bool
  default     = true
}

variable "enable_autoscaling_cpu" {
  description = "Controls if an app autoscaling policy monitoring CPU is created"
  type        = bool
  default     = true
}

variable "enable_autoscaling_memory" {
  description = "Controls if an app autoscaling policy monitoring memory is created"
  type        = bool
  default     = true
}

variable "autoscaling_target_value_memory" {
  description = "Controls the target value for the memory autoscaling policy"
  type        = number
  default     = 70
}

variable "autoscaling_target_value_cpu" {
  description = "Controls the target value for the cpu autoscaling policy"
  type        = number
  default     = 70
}

variable "scale_in_cooldown" {
  description = "The amount of time, in seconds, after a scale in activity completes before another scale in activity can start"
  type        = number
  default     = 120
}

variable "scale_out_cooldown" {
  description = "The amount of time, in seconds, after a scale out activity completes before another scale in activity can start"
  type        = number
  default     = 120
}

variable "create_lb_target_group" {
  description = "Controls if a Load Balancer Target Group is created"
  type        = bool
  default     = true
}

variable "create_iam_role" {
  description = "Controls if an IAM role is created"
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

variable "cloudwatch_retention_in_days" {
  description = "Retention Period for the loadwatch log group"
  type        = string
  default     = 180
}


#####
## ECS Task Definition
#####
variable "task_names" {
  description = "Names to be used for the ECS Task Definition"
  type        = list(string)
  default     = []
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

variable "custom_image_names" {
  description = "Name of the image to be used for the ECS Task Definition"
  type        = list(string)
  default     = []
}

variable "custom_tag_names" {
  description = "Name of the image tag to be used for the ECS Task Definition"
  type        = list(string)
  default     = []
}


variable "default_image_tags" {
  description = "Name of the default image tag to be used for the ECS Task Definition"
  type        = list(string)
  default     = ["latest", "latest", "latest", "latest", "latest", "latest", "latest", "latest", "latest", "latest"]
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
  default     = "/build"
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

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy."
  type        = string
  default     = "0"
}

variable "max_capacity" {
  description = "The max number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy."
  type        = string
  default     = "0"
}

variable "min_capacity" {
  description = "The min number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy."
  type        = string
  default     = "0"
}

variable "deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy."
  type        = string
  default     = "200"
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  type        = string
  default     = "100"
}

variable "enable_ecs_managed_tags" {
  description = "Specifies whether to enable Amazon ECS managed tags for the tasks within the service."
  type        = bool
  default     = true
}

variable "force_new_deployment" {
  description = "Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g. myimage:latest), roll Fargate tasks onto a newer platform version, or immediately deploy ordered_placement_strategy and placement_constraints updates."
  type        = bool
  default     = false
}

variable "health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  type        = string
  default     = "30"
}

variable "iam_role" {
  description = "ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here."
  type        = string
  default     = null
}

variable "container_port" {
  description = "The port on the container to associate with the load balancer."
  type        = string
  default     = "5000"
}

variable "platform_version" {
  description = "The platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST"
  type        = string
  default     = "LATEST"
}

variable "deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  type        = number
  default     = 120
}

variable "autoscaling_scheduled_actions" {
  description = "Custom scheduled scaling actions"
  type        = any
  default     = []
}

variable "task_assigned_iam_policies" {
  description = "Attach IAM roles to each configured task definition"
  type        = any
  default     = []
}

variable "image_tag_mutability"{
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push"{
  description = "(Required) Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = bool
  default     = true
}

variable "ecr_encryption_type"{
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256"
  type        = string
  default     = "AES256"
}

variable "ecr_kms_key"{
  description = "The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR"
  type        = string
  default     = null
}

variable "healthcheck_path" {
  description = "The URL path used to conduct the load balancer healtcheck"
  type        = string
  default     = "/"
}

variable "healthcheck_protocol" {
  description = "The protocol used to conduct the load balancer healtcheck"
  type        = string
  default     = "HTTP"
}

variable "healthcheck_healthy_threshold" {
  description = "The number of checks to pass before deeming resource as healthy"
  type        = number
  default     = 3
}

variable "healthcheck_unhealthy_threshold" {
  description = "The number of checks to fail before deeming resource as unhealthy"
  type        = number
  default     = 3
}

variable "healthcheck_interval" {
  description = "The time between each loadbalancer healthcheck"
  type        = number
  default     = 30
}

variable "protocol" {
  description = "The protocol used to pass traffic to the resource"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "The connection method to the resource (e.g. instance or ip)"
  type        = string
  default     = "ip"
}

variable "stickiness_type" {
  description = "The type of session stickiness used"
  type        = string
  default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
  description = "The session stickiness duration"
  type        = number
  default     = 1800
}

variable "stickiness_enabled" {
  description = "The enabled status of session stickiness"
  type        = bool
  default     = true
}