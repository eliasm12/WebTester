# WebTester
this terraform will use aws provider to install webpagetest/server and webpagetest/agent Dockers on an EC2 instance.

## Usage 
Copy ` terraform.tfvars-example ` to ` terraform.tfvars ` , make sure you add the values for the following variables inside the file :

* `aws-access-key` AND `aws-secret-key` your AWS access and secret key that you can get from IAM https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html make sure you attach an administrator policy to your user

* `aws-region` the AWS region where you want to launch the infrastructure

* `management-ip`  you public ip address subnets , to allow SSH and HTTP Connection from them 

### Terraform

After that you can make `terraform init` and `terraform apply` to create the infrastructure in you AWS Account