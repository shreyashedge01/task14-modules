resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_public_a_name
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_public_b_name
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_c_cidr
  availability_zone       = var.az_c
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_public_c_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.rt.id
}