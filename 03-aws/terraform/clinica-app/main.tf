data "aws_vpc" "vpc" {
  tags = {
    role = "vpc"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  tags = {
    role = "subnet"
    tier = "public"
  }
}

resource "random_id" "index" {
  byte_length = 2
}

# https://www.daringway.com/how-to-select-one-random-aws-subnet-in-terraform/
locals {
  subnet_ids_list = tolist(data.aws_subnets.public.ids)  
  subnet_ids_random_index = random_id.index.dec % length(data.aws_subnets.public.ids)
  instance_subnet_id = local.subnet_ids_list[local.subnet_ids_random_index]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name    = "name"
    values  = ["*ubuntu-*-20.04-amd64-server*"]
  }
}

resource "aws_instance" "instance" {
  ami             = data.aws_ami.ubuntu.id 
  instance_type   = "t3.medium"
  subnet_id       = local.instance_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  user_data       = file("${path.module}/user-data.sh")
  tags            = merge( local.common_tags,
                        { Name = "clinica-app-host" }
                    )
  
}

resource "aws_security_group" "allow-ssh" {
 name        = "docker-host-allow-ssh"
 description = "Allow SSH inbound traffic"
 vpc_id      = data.aws_vpc.vpc.id


 ingress {
   description = "SSH from the internet"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
   description = "HTTP from the internet"
   from_port   = 8080
   to_port     = 8080
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }


 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

  tags  = merge( local.common_tags,
              { Name = "docker-host-allow-ssh" }
          )
}