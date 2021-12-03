resource "aws_ami_from_instance" "hun_ami" {
  name = "${var.name}-ami"
  source_instance_id = aws_instance.hun_web.id
  depends_on = [
    aws_instance.hun_web
  ]
}

resource "aws_launch_configuration" "hun_lacf" {
  name = "${var.name}-ami"
  image_id = aws_ami_from_instance.hun_ami.id
  instance_type = "t2.micro"
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.hun_sg.id]
  key_name = var.key
  user_data =<<-EOF
                #!/bin/bash
                systemctl start httpd
                systemctl enable httpd
                EOF
}

resource "aws_placement_group" "hun_pg" {
  name     = "${var.name}-pg"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "hun_atsg" {
  name                      = "${var.name}-atsg"
  min_size                  = var.nb_2
  max_size                  = var.min_s
  health_check_grace_period = var.max_s
  health_check_type         = var.hc_type
  desired_capacity          = var.nb_2
  force_delete              = false   #fals하면 안지워짐
  launch_configuration      = aws_launch_configuration.hun_lacf.name
  #placement_group           = aws_placement_group.hun_pg.id
  vpc_zone_identifier       = [aws_subnet.hun_pub[0].id, aws_subnet.hun_pub[1].id]

}

resource "aws_autoscaling_attachment" "hun_asatt" {
  autoscaling_group_name = aws_autoscaling_group.hun_atsg.id
  alb_target_group_arn = aws_lb_target_group.hun_albtg.arn
}