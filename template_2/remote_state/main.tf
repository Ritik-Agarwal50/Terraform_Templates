//Defineing aws s3 bucket and Ec2 instance
terraform{
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.13"
        }
    }   
    required_version = ">=1.2.0"
}
//Region name, It is not manditorty to mention the region name in the provider block
provider "aws" {
    region = "ap-south-1"
}

//Creating a s3 bucket
resource "aws_s3_bucket" "example" {
    bucket = "my-terraform-bucket-test"
}
//Creating a s3 bucket with versioning
resource "aws_s3_bucket_versioning" "test" {
    bucket = aws_s3_bucket.example.bucket
    versioning_configuration {
        status = true
    }
}
//Creating a s3 bucket with server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "test" {
    bucket = aws_s3_bucket.example.bucket
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}
// Creating a ec2 instance
resource "aws_instance" "myinstance" {
    ami = "enter you ami id"
    instance_type = "t3.micro"
    tags = {
        Name = "my-instance"
    }
}
// configing the dynamodb table
//below listed args are manditory to create a dynamodb table
// In attribute block we can define the type of the attribute and the name of the attribute
// type = "S" means the attribute is of type string
resource "aws_dynamodb_table" "lock_file" {
    name = "lock_file"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}