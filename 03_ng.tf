resource "aws_eip" "hun_ngw_ip" {
  vpc = true
}

resource "aws_nat_gateway" "hun_ngw" {
  allocation_id = aws_eip.hun_ngw_ip.id
  subnet_id = aws_subnet.hun_pub[0].id
  tags = {
      "Name" = "${var.name}-ngw"
  }
}

resource "aws_route_table" "hun_ngwrt" {
  vpc_id = aws_vpc.hun_vpc.id

  route {
      cidr_block = var.cidr_route
      gateway_id = aws_nat_gateway.hun_ngw.id
  }
  tags ={
      "Name" = "${var.name}-ngwrt"
  }
}

resource "aws_route_table_association" "hun_ngwass_pri" {
  count = length(var.pri_sub)
  subnet_id = aws_subnet.hun_pri[count.index].id
  route_table_id = aws_route_table.hun_ngwrt.id
}



resource "aws_route_table_association" "hun_ngwass_pridb" {
  count = length(var.pri_subdb)
  subnet_id = aws_subnet.hun_pridb[count.index].id
  route_table_id = aws_route_table.hun_ngwrt.id
}
