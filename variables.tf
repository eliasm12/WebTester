variable "aws-access-key"{
    type = string
}

variable "aws-secret-key" {
  type = string
}

variable "aws-region" {
  type = string
}

variable "management-ip" {
  default = []
  type = list(string)
}

variable "ami-id" {
  default = ""
  type = string
}