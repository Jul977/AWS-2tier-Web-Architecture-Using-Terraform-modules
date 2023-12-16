# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

#create internet gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

#use data source to get all availability zoness in a region
data "aws_availability_zones" "available_zones" {}

#Creating public subnet az1
resource "aws_subnet" "pub_sub_az1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pub_sub_az1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub_az1"
  }
}

#Creating public subnet az2
resource "aws_subnet" "pub_sub_az2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pub_sub_az2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub_az2"
  }
}

#Creating public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public_rt"
  }
}

#Associating public route table to public subnet az1
resource "aws_route_table_association" "pub_sub_az1_rt" {
  subnet_id      = aws_subnet.pub_sub_az1.id
  route_table_id = aws_route_table.public_rt.id
}

#Associating public route table to public subnet az2
resource "aws_route_table_association" "pub_sub_az2_rt" {
  subnet_id      = aws_subnet.pub_sub_az2.id
  route_table_id = aws_route_table.public_rt.id
}

#Creating private web subnet az1
resource "aws_subnet" "pri_web_az1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pri_web_az1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri_web_az1"
  }
}

#Creating private web subnet az2
resource "aws_subnet" "pri_web_az2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pri_web_az2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri_web_az2"
  }
}

#Creating private db subnet az1
resource "aws_subnet" "pri_db_az1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pri_db_az1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri_db_az1"
  }
}

#Creating private db subnet az2
resource "aws_subnet" "pri_db_az2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pri_db_az2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri_db_az2"
  }
}

