resource "aws_ecr_repository" "platform_app_ecr_repository" {
  name = "platform-app"
  force_delete = true
}