# Install VM's modified from Leon Robinson

provider "aws" {
  region = "eu-west-2"
}

// Input Variables

variable "name-prefix" {
  type        = string
  default     = "Petclinic"
  description = "prefix for instance name"
}

variable "sshkeypairname" {
  type        = string
  description = "ssh keypair name in aws"
}



// Local Variables

locals {
  imageid      = "ami-0bd2099338bc55e6d"
  instanceType = "t2.small"
}


resource "aws_security_group" "petclinic" {
  name = "petclinic"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Services"
    from_port   = 8000
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "Front-end"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "Back-End"
    from_port   = 9966
    to_port     = 9966
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "docker" {
  ami                    = local.imageid
  instance_type          = local.instanceType
  key_name               = var.sshkeypairname
  vpc_security_group_ids = [aws_security_group.petclinic.id]
  user_data              = <<EOF
#cloud-config
sources:
  ansible:
    source "ppa:ansible/ansible"
packages:
  - software-properties-common
  - ansible
runcmd:
  - git clone https://github.com/Crush-Steelpunch/Minikube-Aws-Env.git /tmp/Minikube-Aws-Env

EOF

  root_block_device {
    volume_size = 20
  }
  tags = {
    Name = "${var.name-prefix}-petclinic"
  }
}



output "amazon_pubip" {
  value = aws_instance.docker.public_ip
}
