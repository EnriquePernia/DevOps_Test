provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# This gives EC2 instances access to S3 buckets
data "aws_iam_policy" "CodeDeploy_EC2" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_role" "codeDeploy_role_EC2" {
  name = "EC2_CodeDeploy_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Role = "EC2-CodeDeploy"
  }
}

resource "aws_iam_instance_profile" "EC2_codeDeploy_profile" {
  name = "EC2_codeDeploy_profile"
  role = aws_iam_role.codeDeploy_role_EC2.name
}

resource "aws_iam_role_policy" "codeDeploy_ec2_policy" {
  name = "EC2_CodeDeploy_policy"
  role = aws_iam_role.codeDeploy_role_EC2.id
  policy = data.aws_iam_policy.CodeDeploy_EC2.policy
}

# Now lets edit code deploy
# THis gives codeDeploy access to EC2
data "aws_iam_policy" "CodeDeploy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_role" "codeDeploy_role" {
  name = "CodeDeploy_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Role = "CodeDeploy"
  }
}

resource "aws_iam_instance_profile" "codeDeploy_profile" {
  name = "codeDeploy_profile"
  role = aws_iam_role.codeDeploy_role.name
}

resource "aws_iam_role_policy" "codeDeploy_policy" {
  name = "codeDeploy_policy"
  role = aws_iam_role.codeDeploy_role.name
  policy = data.aws_iam_policy.CodeDeploy.policy
}