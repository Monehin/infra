provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "example" {
  ami = "ami-0b45ae66668865cd6"
  instance_type = "t2.micro"

  tags = {
    Name="HelloWorld"
  }
}