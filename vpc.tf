resource "aws_vpc" "vpc_irlanda" {
  cidr_block = var.irlanda_cidr
  tags = {
    "Name" = "vpc_irlanda_${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_irlanda.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet_${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet_primaria" {
  vpc_id     = aws_vpc.vpc_irlanda.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "private_subnet_${local.sufix}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_irlanda.id

  tags = {
    Name = "IGW vpc Irlanda_${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_irlanda.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public CRT_${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_irlanda.id

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public Instance SG_${local.sufix}"
  }
}