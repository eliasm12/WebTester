
variable "iam-instance-profile" {
  default = ""
  type = string
}

variable "instance-type" {
  default = "t2.micro"
  type = string
}

variable "name" {
  type = string
}

variable "key-name" {
  type = string
}

variable "ami-id" {
  type = string
}

variable "subnet-id" {
  default = ""
  type = string
}

variable "vpc-security-group-ids" {
  default = []
  type = list(string)
}

variable "costcenter" {
    default = ""
    type = string  
}

variable "envirement" {
    default = "Developement"
    type = string
}

variable "volume-size" {
  default = "15"
  type = string
}