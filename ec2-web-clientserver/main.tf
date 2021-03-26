resource "aws_instance" "default" {
  ami                    = var.ami-id
  iam_instance_profile   = var.iam-instance-profile
  instance_type          = var.instance-type
  private_ip             = var.private-ip
  subnet_id              = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  key_name               = var.key-name

  user_data = <<EOF
#!/bin/bash
sudo apt-get update && sudo apt-get install docker.io
sudo usermod -aG docker ubuntu
docker pull webpagetest/server
docker pull webpagetest/agent
docker run -p 80:80/tcp webpagetest/server -d

EOF

  tags = {
    "Name" = var.name
    "Envirement" = var.envirement
    "CostCenter" = var.costcenter 
  }
}
