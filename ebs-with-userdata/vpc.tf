#aws_vpc resources
resource "aws_vpc" "vpc_demo" {
  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  enable_classiclink   = var.enable_classiclink

  tags = {
    Name = var.tags
  }
}

#GW for later created public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "internet-gateway-demo"
  }
}

#only one public subnet public_1
resource "aws_subnet" "public_1" {
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"

  tags = {
    Name = "public_1-demo"
  }
}

#RT for public subnet
resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc_demo.id

  route {
    cidr_block = "10.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table-demo"
  }
}

#Associatoin of public subnet to RT
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id                   # Id value of public_1 
  route_table_id = aws_route_table.route-public.id          # Id value of RT to be connected 
}
