terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

resource "aws_security_group" "instance" {
    
    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      protocol = "tcp"
      from_port = var.server_port
      to_port = var.server_port
    }
}

variable "server_port" {
    description = "Default port number"
    type = number
    default = 8080
}

output "sg_id" {
  value = aws_security_group.instance.id
}
