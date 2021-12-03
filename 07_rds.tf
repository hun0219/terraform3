resource "aws_db_instance" "hun_mydb" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = var.mysql
  engine_version = "8.0"
  instance_class = "db.t2.micro"
  name = var.mydb
  identifier = var.mydb
  username = "admin"
  password = "admin"
  parameter_group_name = "default.mysql8.0"
  availability_zone = "${var.region}${var.ava_zone[0]}"
  db_subnet_group_name = aws_db_subnet_group.hun_dbsg.id
  vpc_security_group_ids = [aws_security_group.hun_sg.id]
  skip_final_snapshot = true
  tags = {
      "Name" = "${var.name}-db"
  }
}

resource "aws_db_subnet_group" "hun_dbsg" {
    name = "${var.name}-dbsg"
    subnet_ids = [aws_subnet.hun_pridb[0].id,aws_subnet.hun_pridb[1].id]
}