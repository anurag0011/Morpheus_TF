### Build Routes
# DR Internet Gateway
resource "aws_internet_gateway" "dr" {
  vpc_id = aws_vpc.dr.id

  tags = {
    Name = "dr"
  }
}


# DR Routers
resource "aws_route_table" "dr" {
  vpc_id = aws_vpc.dr.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dr.id
  }

  tags = {
    Name = "dr"
  }
}


# DR Subnet Associations
resource "aws_route_table_association" "web" {
    count = "${length(aws_subnet.web)}"

    subnet_id      = "${element(aws_subnet.web.*.id, count.index)}"
    route_table_id = "${aws_route_table.dr.id}"
}

resource "aws_route_table_association" "db" {
    count = "${length(aws_subnet.db)}"

    subnet_id      = "${element(aws_subnet.db.*.id, count.index)}"
    route_table_id = "${aws_route_table.dr.id}"
}

resource "aws_route_table_association" "app" {
    count = "${length(aws_subnet.app)}"

    subnet_id      = "${element(aws_subnet.app.*.id, count.index)}"
    route_table_id = "${aws_route_table.dr.id}"
}