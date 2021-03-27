resource "aws_vpc" "webtester" {
cidr_block = "10.0.0.0/16"   
enable_dns_hostnames = true 

tags = {
    "Name" = "Webtester VPC"
}
}

resource "aws_subnet" "webtester-subnet-public-1" {
    availability_zone_id = "euw1-az1"  
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.webtester.id
    map_public_ip_on_launch = true
    tags = {
      "Name" = "Webtester-subnet-public-1"
    }
}

resource "aws_internet_gateway" "webtester" {
    vpc_id = aws_vpc.webtester.id

    tags = {
      "Name" = "Webtester IGW"
    }
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.webtester.id

    route = [ {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.webtester.id
      egress_only_gateway_id    = ""
      instance_id               = ""
      ipv6_cidr_block           = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_peering_connection_id = ""
      vpc_endpoint_id           = ""
      local_gateway_id          = ""
    } ]

    tags = {
      "Name" = "Public Webtester RTB"
    }
  
}

resource "aws_route_table_association" "webtester-public-subnet" {
    subnet_id = aws_subnet.webtester-subnet-public-1.id 
    route_table_id = aws_route_table.public.id
  
}


resource "aws_security_group" "webtester-ec2" {
  name        = "webtester-ec2"
  description = "Allow inbound http and ssh"
  vpc_id      = aws_vpc.webtester.id
  


  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.management-ip
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.management-ip
  }

  ingress {
    description = "Allow Server-Agent"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ aws_vpc.webtester.cidr_block ]
    } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Webtester-EC2"
  }
}