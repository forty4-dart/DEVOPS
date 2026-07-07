# resource "aws_ecs_cluster" "main" {
#   name = "${var.project_name}-cluster"

#   tags = {
#     Name = "${var.project_name}-cluster"
#   }
# }

# resource "aws_ecs_task_definition" "app" {
#   family                   = "${var.project_name}-task"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]

#   cpu    = "256"
#   memory = "512"

#  execution_role_arn = aws_iam_role.ecs_task_execution.arn

#   container_definitions = jsonencode([
#     {
#       name  = "app"
#       image = "nginx:latest"

#       essential = true

#       portMappings = [
#         {
#           containerPort = 80
#           hostPort      = 80
#           protocol      = "tcp"
#         }
#       ]
#     }
#   ])
# }
# resource "aws_ecs_service" "app" {
#   name            = "${var.project_name}-service"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.app.arn

#   desired_count = 1

#   launch_type = "FARGATE"
#   load_balancer {
#   target_group_arn = aws_lb_target_group.ecs.arn
#   container_name   = "app"
#   container_port   = 80
# }
#   network_configuration {
#     subnets = [
#       aws_subnet.private.id,
#       aws_subnet.private_2.id,
#     ]

#     security_groups = [
#       aws_security_group.ecs.id
#     ]

#     assign_public_ip = true
#   }
# }
# # resource "aws_ecs_service" "app" {
# #   name            = "${var.project_name}-service"
# #   cluster         = aws_ecs_cluster.main.id
# #   task_definition = aws_ecs_task_definition.app.arn

# #   desired_count = 1
# #   launch_type   = "FARGATE"

# #   depends_on = [
# #     aws_lb_listener.http
# #   ]

# #   load_balancer {
# #     target_group_arn = aws_lb_target_group.ecs.arn
# #     container_name   = "app"
# #     container_port   = 80
# #   }

# #   network_configuration {
# #     subnets = [
# #       aws_subnet.public.id,
# #       aws_subnet.public_2.id
# #     ]

# #     security_groups = [
# #       aws_security_group.ecs.id
# #     ]

# #     assign_public_ip = true
# #   }
# # }

resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  tags = {
    Name = "${var.project_name}-cluster"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn

  desired_count = 1
  launch_type   = "FARGATE"

  depends_on = [
    aws_lb_listener.http
  ]

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs.arn
    container_name   = "app"
    container_port   = 80
  }

  network_configuration {
    subnets = [
      aws_subnet.public.id,
      aws_subnet.public_2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }
}