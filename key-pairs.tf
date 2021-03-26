resource "aws_key_pair" "tester-ec2-key" {
    key_name = "tester-ec2-key"
    public_key = file("./tester-ec2-key.pub")

}