### Build Networks
# Primary
resource "aws_subnet" "web" {
    vpc_id     = aws_vpc.primary.id
    count      = length(data.aws_availability_zones.available.names)
    cidr_block = cidrsubnet(aws_vpc.primary.cidr_block, 8, count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
        Name = "web_${count.index}"
    }
}

resource "aws_subnet" "db" {
    vpc_id     = aws_vpc.primary.id
    count      = length(data.aws_availability_zones.available.names)
    cidr_block = cidrsubnet(aws_vpc.primary.cidr_block, 8, (count.index + 10))
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
        Name = "db_${count.index}"
    }
}

resource "aws_subnet" "app" {
    vpc_id     = aws_vpc.primary.id
    count      = length(data.aws_availability_zones.available.names)
    cidr_block = cidrsubnet(aws_vpc.primary.cidr_block, 8, (count.index + 20))
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
        Name = "app_${count.index}"
    }
}

# Database Subnet Group
resource "aws_db_subnet_group" "dbgroup" {
    subnet_ids     = aws_subnet.db.*.id
    name        = "db_group"
}