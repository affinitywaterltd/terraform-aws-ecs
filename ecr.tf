resource "aws_ecr_repository" "this" {
  count = var.create_ecs ? length(var.task_names) : 0

  name                 = element(var.task_names, count.index)
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.ecr_encryption_type
    kms_key = var.ecr_kms_key
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_all" {
  count = var.create_ecs ? length(var.task_names) : 0

  repository = aws_ecr_repository.this[count.index].name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "AllowPushPull",
            "Effect": "Allow",
            "Principal": {
                "AWS": [${join("\",\"", format("'%s'", var.ecr_cross_account_princpals))}]
            },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload"
            ]
        }
    ]
}
EOF
}