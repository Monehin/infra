provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "example" {
  ami = "ami-0e8d228ad90af673b"
  instance_type = "t2.micro"
  # key_name = aws_key_pair.my_key_pair.key_name

  vpc_security_group_ids = [ aws_security_group.instance.id ]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name="HelloWorld"
  }
}

resource "aws_security_group" "instance" {
  name = "web"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_key_pair" "my_key_pair" {
#   key_name   = "my-key-pair"  # Name of your key pair
#   public_key = file("${path.module}/my-key-pair.pub")
# }