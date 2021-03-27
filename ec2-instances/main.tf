resource "aws_instance" "default" {
  ami                    = var.ami-id
  iam_instance_profile   = aws_iam_instance_profile.webtest_profile.id
  instance_type          = var.instance-type
  subnet_id              = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  key_name               = var.key-name
  root_block_device {
    volume_size = var.volume-size
  
  }
  user_data = var.user-data


  tags = {
    "Name" = var.name
    "Envirement" = var.envirement
    "CostCenter" = var.costcenter 
  }
}



