# WebTester
this terraform will use aws provider to install webpagetest/server and webpagetest/agent Dockers on an EC2 instance.

## Usage 
1   you will need first to create ssh keys to use them to connect later to the EC2 , please create ssh key and public key and put them inside this project root directory, use the name : ***tester-ec2-key.key*** and ***tester-ec2-key.pub*** for the private and public key respectively, on linux you can generate them with the command ` ssh-keygen -t rsa -b 2048 `


2   Copy ` terraform.tfvars-example ` to ` terraform.tfvars ` , make sure you add the values for the following variables inside the file :

    * `aws-access-key` AND `aws-secret-key` your AWS access and secret key that you can get from IAM https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html make sure you attach an administrator policy to your user

    * `aws-region` the AWS region where you want to launch the infrastructure

    * `management-ip`  you public ip address subnets , to allow SSH and HTTP Connection from them 

## Deploy with Terraform

After that you can make `terraform init` and `terraform apply` to create the infrastructure in you AWS Account

## Add custom document

you can modify the file ***documents.tf*** to add any document that you like to run, think of a document as a playbook, there is an example run command of ` docker ps ` .
After adding your documents you can run them with AWS SSM , via console, cli or sdk , you can save the output to cloudwatch AND/OR S3.

## TODO

* the permissions inside ec2-web-client-server/main.tf can be tuned to you desired to specify a bucket name or a cloudwatch log group, since this is a test a full permission on S3 and Cloudwatch is used , those policies should not be used in a  production envirement so please modify them to your need. 

* Move from Ec2 to ECS