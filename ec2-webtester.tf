module "ec2-webtester" {
    source = "./ec2-web-clientserver"
    ami-id = var.ami-id
    name = "Web Tester client-server"
    key-name = aws_key_pair.tester-ec2-key.key_name
    vpc-security-group-ids = [aws_security_group.webtester-ec2.id]
    subnet-id = aws_subnet.webtester-subnet-public-1.id
  }