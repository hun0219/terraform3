resource "aws_lb" "hun_alb" {
  name = "${var.name}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.hun_sg.id]
  subnets = [aws_subnet.hun_pub[0].id,aws_subnet.hun_pub[1].id]
  tags = {
      "Name" = "${var.name}-alb"
  }
}

output "dns_name" {
  value = aws_lb.hun_alb.dns_name
}

resource "aws_lb_target_group" "hun_albtg" {
  name     = "${var.name}-albtg"
  port     = var.port_http
  protocol = var.pro_HTTP
  vpc_id   = aws_vpc.hun_vpc.id

  health_check {
    enabled             = true
    healthy_threshold    = 3
    interval            = 5
    matcher             = "200"
    path                = "/health.html"
    port                = "traffic-port"
    protocol            = var.pro_HTTP
    timeout             = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "hun_alblis" {
  load_balancer_arn = aws_lb.hun_alb.arn
  port              = var.port_http
  protocol          = var.pro_HTTP

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hun_albtg.arn
  }
}

resource "aws_lb_target_group_attachment" "hun_albtgatt" {
  target_group_arn = aws_lb_target_group.hun_albtg.arn
  target_id        = aws_instance.hun_web.id
  port             = var.port_http
}
