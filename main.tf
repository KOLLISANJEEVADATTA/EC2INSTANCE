resource "aws_s3_bucket" "name" {
  bucket = "terraformbucket-2023"

  tags = {
    Name = "terraformbucket"
  }
}


resource "aws_vpc" "VPC" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "TERRAFORM-VPC"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "IGW-1"
  }

}

resource "aws_subnet" "SUBNET1" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = "10.20.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "TF-PUBLIC-SUBNET-1"
  }
}

resource "aws_subnet" "SUBNET2" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = "10.20.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "TF-PUBLIC-SUBNET-2"
  }
}

resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "TF-PUBLIC-RT"
  }
}

resource "aws_route_table_association" "RT-ASS-1" {
  subnet_id      = aws_subnet.SUBNET1.id
  route_table_id = aws_route_table.terraform-public.id
}

resource "aws_route_table_association" "RT-ASS-2" {
  subnet_id      = aws_subnet.SUBNET2.id
  route_table_id = aws_route_table.terraform-public.id
}


resource "aws_security_group" "SG" {
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    description = "TCP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG"
  }

}
