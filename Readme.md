#Webtester
this will install the webtest server and the webtest agent as dockers on an AWS EC2 instance.

##Usage 
Copy ` terraform.tfvars-example ` to ` terraform.tfvars ` , make sure you add the values for the following variables inside the file :

* `aws-access-key` AND `aws-secret-key` your AWS access and secret key that you can get from IAM https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html make sure you attach an administrator policy to your user

* `aws-region` the AWS region where you want to launch the infrastructure

* `management-ip`  you public ip address subnets , to allow SSH and HTTP Connection from them 

* `ami-id` go to the AWS console, and get the AMI ID you want for the specific region you are using