provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "db" {
    ami = "ami-079db87dc4c10ac91"
    instance_type = "t2.micro"
    
  
}

resource "aws_instance" "db2" {
    ami = "ami-079db87dc4c10ac91"
    instance_type = "t2.micro"
    depends_on = [ aws_instance.db ]
    
  
}