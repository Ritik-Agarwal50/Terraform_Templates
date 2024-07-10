terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.13"
        }
    }
    required_version = ">=1.2.0"
}
provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "temp_server" {
  ami = "ami details"
  instance_type = "t3.micro"

  tags = {
    Name = "temp_server"
  }
}