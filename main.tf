provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = "100.10.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "ps_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.10.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    "Name" = "public_1"
  }
}



resource "aws_subnet" "ps_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.10.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"
  tags = {
    "Name" = "public_2"
  }
}

resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.main.id
  tags = {
    "name" = "ig1"
  }
}


resource "aws_route_table" "atable" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig1.id
  }
  tags = {
    "Name" = "public_rt"
  }
}


resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.ps_1.id
  route_table_id = aws_route_table.atable.id

}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.ps_2.id
  route_table_id = aws_route_table.atable.id

}
