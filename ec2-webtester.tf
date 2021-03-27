data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "ec2-webtester-server" {
    ami-id  = data.aws_ami.ubuntu.id
    role-name = "ec2-webtester-server"
    source = "./ec2-instances"
    name = "ec2-server"
    volume-size = "15"
    key-name = aws_key_pair.tester-ec2-key.key_name
    vpc-security-group-ids = [aws_security_group.webtester-ec2.id]
    subnet-id = aws_subnet.webtester-subnet-public-1.id
    user-data = <<EOF
#!/bin/bash
sudo apt-get update && sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
docker pull webpagetest/server
docker run -d -p 80:80/tcp webpagetest/server

EOF
  }

module "ec2-webtester-agent" {
    ami-id  = data.aws_ami.ubuntu.id
    role-name = "ec2-webtester-agent"
    source = "./ec2-instances"
    name = "ec2-agent"
    volume-size = "15"
    key-name = aws_key_pair.tester-ec2-key.key_name
    vpc-security-group-ids = [aws_security_group.webtester-ec2.id]
    subnet-id = aws_subnet.webtester-subnet-public-1.id
    user-data = <<EOF
#!/bin/bash
sudo apt-get update && sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
docker pull webpagetest/agent
docker run -d -p 80:80 --network="host" -e "SERVER_URL=http://server.pagespeed.test/work/" -e "LOCATION=Test" webpagetest/agent

EOF
  }