# This gives EC2 instances access to S3 buckets
data "aws_iam_policy" "CodeDeploy_EC2" {
  arn = var.aws_EC2codeDeploy_ARN
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com",
                      "codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codeDeploy_role_EC2" {
  name = "EC2_CodeDeploy_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json

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
  arn = var.aws_codeDeploy_ARN
}

resource "aws_iam_role" "codeDeploy_role" {
  name = "CodeDeploy_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json

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