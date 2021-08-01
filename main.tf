terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

resource "aws_instance" "webserver"{
  instance_type = "t2.micro"
  ami = "ami-05fa05752fc432eeb"
  vpc_security_group_ids = [ aws_security_group.instance.id ]

  user_data = <<-EOF
            #!/bin/bash
            echo "Alvaro el magnifico" > index.html
            nohup busybox httpd -f -p ${var.server_port} &
            EOF
}

resource "aws_security_group" "instance" {
    name = "vivien-SingleWS-aws1"

    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      protocol = "tcp"
      from_port = var.server_port
      to_port = var.server_port
    }
}

variable "server_port" {
    description = "Default WebServer port number"
    type = number
    default = 8080
}

output "public_ip" {
    description = "WebServer public IP provided by AWS on default VPC and default subnet"
    value = aws_instance.webserver.public_ip
}

output "public_dns" {
    value = aws_instance.webserver.public_dns
    description = "WebServer public DNS"
}
