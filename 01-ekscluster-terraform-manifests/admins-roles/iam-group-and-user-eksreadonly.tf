# Resource: AWS IAM Group 
resource "aws_iam_group" "eksreadonly_iam_group" {
  name = "${var.cluster_name}-eksreadonly"
  path = "/"
}

# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "eksreadonly_iam_group_assumerole_policy" {
  name  = "${var.cluster_name}-eksreadonly-group-policy"
  group = aws_iam_group.eksreadonly_iam_group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid    = "AllowAssumeOrganizationAccountRole"
        Resource = "${aws_iam_role.eks_readonly_role.arn}"
      },
    ]
  })
}


# Resource: AWS IAM User 
resource "aws_iam_user" "eksreadonly_user" {
  name = "${var.cluster_name}-eksreadonly1"
  path = "/"
  force_destroy = true
  tags = var.common_tags
}

# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "eksreadonly" {
  name = "${var.cluster_name}-eksreadonly-group-membership"
  users = [
    aws_iam_user.eksreadonly_user.name
  ]
  group = aws_iam_group.eksreadonly_iam_group.name
}