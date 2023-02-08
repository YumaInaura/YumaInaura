resource "aws_ecs_service" "ex" {
  name            = "ex-service"
  cluster         = "ex"
  task_definition = "rails-task"

  launch_type = "FARGATE"
  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-08c283ec45b140c3a"]
    subnets          = ["subnet-06a89891663ab6b13", "subnet-0a1be7e1bcb530048"]
  }

  # desired_count   = 3
  # iam_role        = aws_iam_role.foo.arn
  # depends_on      = [aws_iam_role_policy.foo]

  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }

  load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:842696858454:targetgroup/tg3435/b61e6c63da5b6c4e"
    container_name   = "mongo"
    container_port   = 80
  }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}
