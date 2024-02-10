resource "aws_iam_policy" "ca_policy" {
  name        = "AmazonEKSClusterAutoscalerPolicy"
  description = ""

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "autoscaling:DescribeAutoScalingGroups",
              "autoscaling:DescribeAutoScalingInstances",
              "autoscaling:DescribeLaunchConfigurations",
              "autoscaling:DescribeTags",
              "autoscaling:SetDesiredCapacity",
              "autoscaling:TerminateInstanceInAutoScalingGroup",
              "ec2:DescribeLaunchTemplateVersions"
          ],
          "Resource": "*",
          "Effect": "Allow"
      }
  ]
}
EOT

}

data "aws_iam_policy_document" "assume_role_with_oidc" {


  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::518340611346:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/4AF960C7631C936307A5AC80FB2D81E1"]
    }

    condition {
      test     = "StringEquals"
      variable = "oidc.eks.us-west-2.amazonaws.com/id/4AF960C7631C936307A5AC80FB2D81E1:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }
  }

}

resource "aws_iam_role" "ca_role" {
  name        = "AmazonEKSClusterAutoscalerRole"
  description = "IRSA role for Cluster Autoscaler"

  assume_role_policy = data.aws_iam_policy_document.assume_role_with_oidc.json
}

resource "aws_iam_role_policy_attachment" "ca_policy" {

  role       = aws_iam_role.ca_role.name
  policy_arn = aws_iam_policy.ca_policy.arn
}