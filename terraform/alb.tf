resource "aws_lb" "strapi" {
  name               = "docker-strapi-alb"
  load_balancer_type = "application"
  subnets             = [
    aws_subnet.public.id,
    aws_subnet.public_2.id
  ]
  security_groups    = [aws_security_group.alb_sg.id]
}

# BLUE target group
resource "aws_lb_target_group" "blue" {
  name        = "blue-docker-strapi-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path    = "/"
    matcher = "200-399"
  }
}

# GREEN target group
resource "aws_lb_target_group" "green" {
  name        = "green-docker-strapi-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path    = "/"
    matcher = "200-399"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.strapi.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}
