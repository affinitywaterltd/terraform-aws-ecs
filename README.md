# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS, ECR, IAM role, ALB Target Groups, AutoSclaing Policy etc.

* [ECS-Cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster)
* [ECS-Service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service)
* [ECS-Task Definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition)
* [ECR](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)
* [ECR-Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy)
* [IAM](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
* [ALB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)
* [AutoScaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target)

This Terraform module will provide the required resources for an entire ECS cluster and all the required resources within an existing VPC.

## Terraform versions

Terraform 0.12. and above

## Usage

```hcl
module "ecs" {
  source = "github.com/affinitywaterltd/terraform-aws-ecs"

  name               = "example"
  environment_name   = "dev"

  task_names = ["example-api", "example-ui"]
  subnets = [aws_subnet.example.id]
  security_groups = [aws_security_group.example.id]

  tags = {
    Environment = "Development"
  }
}
```

## Conditional creation

Sometimes you need to have a way to create ECS resources conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create_ecs`.

```hcl
# ECS cluster will not be created
module "ecs" {
  source  = "github.com/affinitywaterltd/terraform-aws-ecs"

  create_ecs = false
  # ... omitted
}
```

## Examples

* [Complete ECS](https://github.com/terraform-aws-modules/terraform-aws-ecs/tree/master/examples/complete-ecs)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 2.48 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.48 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| capacity\_providers | List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE\_SPOT. | `list(string)` | `[]` | no |
| container\_insights | Controls if ECS Cluster has container insights enabled | `bool` | `false` | no |
| create\_ecs | Controls if ECS should be created | `bool` | `true` | no |
| default\_capacity\_provider\_strategy | The capacity provider strategy to use by default for the cluster. Can be one or more. | `map(any)` | `{}` | no |
| name | Name to be used on all the resources as identifier, also the name of the ECS cluster | `string` | `null` | no |
| tags | A map of tags to add to ECS Cluster | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_ecs\_cluster\_arn | ARN of the ECS Cluster |
| this\_ecs\_cluster\_id | ID of the ECS Cluster |
| this\_ecs\_cluster\_name | The name of the ECS cluster |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Armin Coralic](https://github.com/arminc), [Anton Babenko](https://github.com/antonbabenko) and [other awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-ecs/graphs/contributors).

## License

Apache 2 Licensed. See LICENSE for full details.