resource "aws_ecs_cluster" "ex" {
  name = "ex"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}