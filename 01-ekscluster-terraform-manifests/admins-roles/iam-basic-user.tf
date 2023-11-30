# Resource: AWS IAM User - Basic User (No AWSConsole Access)
resource "aws_iam_user" "basic_user" {
  name = "${var.cluster_name}-eksadmin2"
  path = "/"
  force_destroy = true
  tags = var.common_tags
}

# Resource: AWS IAM User Policy - EKS Dashboard Full Access
resource "aws_iam_user_policy" "basic_user_eks_policy" {
  name = "${var.cluster_name}-eks-dashboard-full-access-policy"
  user = aws_iam_user.basic_user.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:ListRoles",
          "eks:*",
          "ssm:GetParameter"
        ]
        Effect   = "Allow"
        Resource = "*"
        #Resource = "${aws_eks_cluster.eks_cluster.arn}"
      },
    ]
  })
}
