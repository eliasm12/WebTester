output "public-ip" {
  value = aws_instance.default.public_ip
}

output "private-ip" {
  value = aws_instance.default.private_ip
}