resource "aws_ecs_service" "ex" {
  name            = "ex-service"
  cluster         = "ex"
  task_definition = "rails-task"

  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-1f7c0957"]
    subnets          = ["subnet-b062c69b", "subnet-8e151ad5"]
  }

  # desired_count   = 3
  # iam_role        = aws_iam_role.foo.arn
  # depends_on      = [aws_iam_role_policy.foo]

  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }

  # load_balancer {
  #   target_group_arn = aws_lb_target_group.foo.arn
  #   container_name   = "mongo"
  #   container_port   = 8080
  # }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}
