output "ec2-server-public-ip" {
  description = "Page Speed Test Server IP"
  value = module.ec2-webtester-server.public-ip
}

