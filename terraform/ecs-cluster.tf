resource "aws_ecs_cluster" "tf-ex-cluster" {
  name = "tf-ex-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}