################## VPC ##################################
resource "aws_vpc" "vpc" {
  cidr_block              = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.name}-${var.env}-vpc"
    Environment = var.env
  }
}

################## Internet Gateway #######################

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.name}-${var.env}-igw"
    Environment = var.env
  }
}

################## NAT Gateway #######################

resource "aws_eip" "natgw_eip" {
  vpc = true
  tags = {
    Name        = "${var.name}-${var.env}-nat-eip"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = aws_subnet.public_subnet_az1.id

tags   = {
    Name = "${var.name}-${var.env}-nat"
  }

}

################## Subnet ######################################

data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1
  availability_zone       = data.aws_availability_zones.available_zones.names[0]

  tags      = {
    Name    = "${var.name}-${var.env}-public-subnet-${data.aws_availability_zones.available_zones.names[0]}"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az2
  availability_zone       = data.aws_availability_zones.available_zones.names[1]

  tags      = {
    Name    = "${var.name}-${var.env}-public-subnet-${data.aws_availability_zones.available_zones.names[1]}"
  }
}

resource "aws_subnet" "private_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_az1
  availability_zone       = data.aws_availability_zones.available_zones.names[0]

  tags      = {
    Name    = "${var.name}-${var.env}-private-subnet-${data.aws_availability_zones.available_zones.names[0]}"
  }
}

resource "aws_subnet" "private_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_az2
  availability_zone       = data.aws_availability_zones.available_zones.names[1]

  tags      = {
    Name    = "${var.name}-${var.env}-private-subnet-${data.aws_availability_zones.available_zones.names[1]}"
  }
}

resource "aws_subnet" "data_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.data_subnet_az1
  availability_zone       = data.aws_availability_zones.available_zones.names[0]

  tags      = {
    Name    = "${var.name}-${var.env}-data-subnet-${data.aws_availability_zones.available_zones.names[0]}"
  }
}

resource "aws_subnet" "data_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.data_subnet_az2
  availability_zone       = data.aws_availability_zones.available_zones.names[1]

  tags      = {
    Name    = "${var.name}-${var.env}-data-subnet-${data.aws_availability_zones.available_zones.names[1]}"
  }
}

################## Route Table ######################################

resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "${var.name}-${var.env}-public-rtb"
  }
}

resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags       = {
    Name     = "${var.name}-${var.env}-private-rtb"
  }
}

resource "aws_route_table_association" "private_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.private_subnet_az1.id
  route_table_id      = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.private_subnet_az2.id
  route_table_id      = aws_route_table.private_route_table.id
}

resource "aws_route_table" "data_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags       = {
    Name     = "${var.name}-${var.env}-data-rtb"
  }
}

resource "aws_route_table_association" "data_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.data_subnet_az1.id
  route_table_id      = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "data_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.data_subnet_az2.id
  route_table_id      = aws_route_table.data_route_table.id
}