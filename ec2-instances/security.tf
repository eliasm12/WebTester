resource "aws_iam_role" "webtester_role" {
  name = var.role-name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": ["ssm.amazonaws.com","ec2.amazonaws.com"]},
      "Action": "sts:AssumeRole"
    }
  }
EOF
}

resource "aws_iam_instance_profile" "webtest_profile" {
  name = var.role-name
  role = aws_iam_role.webtester_role.name
  depends_on = [ aws_iam_role.webtester_role ]
}


resource "aws_iam_role_policy_attachment" "pol_attach" {
  role       = aws_iam_role.webtester_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "pol_attach_ssm" {
  role       = aws_iam_role.webtester_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "pol_attach_logs" {
  role       = aws_iam_role.webtester_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "pol_attach_s3" {
  role       = aws_iam_role.webtester_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


resource "aws_ssm_activation" "default" {
  name               = "web-ssm-activation"
  description        = "ssm activation"
  iam_role           = aws_iam_role.webtester_role.id
  registration_limit = "5"
  depends_on         = [ aws_iam_role_policy_attachment.pol_attach ,  aws_iam_role_policy_attachment.pol_attach_ssm, aws_iam_role_policy_attachment.pol_attach_logs 
  , aws_iam_role_policy_attachment.pol_attach_s3]   
  }