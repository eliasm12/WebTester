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

module "ec2-webtester" {
    ami-id  = data.aws_ami.ubuntu.id
    source = "./ec2-web-clientserver"
    name = "Web Tester client-server"
    volume-size = "15"
    key-name = aws_key_pair.tester-ec2-key.key_name
    vpc-security-group-ids = [aws_security_group.webtester-ec2.id]
    subnet-id = aws_subnet.webtester-subnet-public-1.id
  }