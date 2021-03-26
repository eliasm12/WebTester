

resource "aws_instance" "default" {
  ami                    = var.ami-id
  iam_instance_profile   = var.iam-instance-profile
  instance_type          = var.instance-type
  subnet_id              = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  key_name               = var.key-name
  root_block_device {
    volume_size = var.volume-size
  
  }

  user_data = <<EOF
#!/bin/bash
sudo apt-get update && sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
docker pull webpagetest/server
docker pull webpagetest/agent
docker run -d -p 80:80/tcp webpagetest/server

EOF

  tags = {
    "Name" = var.name
    "Envirement" = var.envirement
    "CostCenter" = var.costcenter 
  }
}
