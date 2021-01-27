### Build Routes
# Primary Internet Gateway
resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "primary"
  }
}


# Primary Routers
resource "aws_route_table" "primary" {
  vpc_id = aws_vpc.primary.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary.id
  }

  tags = {
    Name = "primary"
  }
}


# Primary Subnet Associations
resource "aws_route_table_association" "web" {
    count = "${length(aws_subnet.web)}"

    subnet_id      = "${element(aws_subnet.web.*.id, count.index)}"
    route_table_id = "${aws_route_table.primary.id}"
}

resource "aws_route_table_association" "db" {
    count = "${length(aws_subnet.db)}"

    subnet_id      = "${element(aws_subnet.db.*.id, count.index)}"
    route_table_id = "${aws_route_table.primary.id}"
}

resource "aws_route_table_association" "app" {
    count = "${length(aws_subnet.app)}"

    subnet_id      = "${element(aws_subnet.app.*.id, count.index)}"
    route_table_id = "${aws_route_table.primary.id}"
}