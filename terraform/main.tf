resource "aws_iam_openid_connect_provider" "github_oidc" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = ["1C58A3A8518E8759BF075B76B750D4F2DF264FCD", "6938fd4d98bab03faadb97b34396831e3780aea1"]
}

output "github_oidc" {
  value = aws_iam_openid_connect_provider.github_oidc.url
}
data "aws_iam_policy_document" "github_oidc_assume_role_policy_doc" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_oidc.arn]
    }

    condition {
      test     = "StringLike"
      variable = "${aws_iam_openid_connect_provider.github_oidc.url}:sub"
      values   = ["repo:jdial1996/platform-app:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "${aws_iam_openid_connect_provider.github_oidc.url}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_oidc_iam_role" {
  name               = "github-oidc-role-rw"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role_policy_doc.json
}

data "aws_iam_policy_document" "ecr_push_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_push_policy" {
  name        = "ecr_push_policy"
  description = "Allow Push to ECR repositories"
  policy      = data.aws_iam_policy_document.ecr_push_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "ecr_push_policy_attachment" {
  role       = aws_iam_role.github_oidc_iam_role.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}