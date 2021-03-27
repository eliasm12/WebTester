resource "aws_route53_zone" "private" {
  name = "pagespeed.test"

  vpc {
    vpc_id = aws_vpc.webtester.id
  }
}

resource "aws_route53_record" "server" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "server.pagespeed.test"
  type    = "A"
  ttl     = "30"
  records = [ module.ec2-webtester-server.private-ip ]
  depends_on = [ aws_route53_zone.private ]
}