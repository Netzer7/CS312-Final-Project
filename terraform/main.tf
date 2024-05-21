provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.main.id
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow Minecraft traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft" {
  ami           = "ami-01cd4de4363ab6ee8" # Amazon Linux 2 AMI
  instance_type = "c5.large"
  subnet_id     = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Minecraft Server"
  }
  
  key_name = "Desktop" # Make sure you have this key pair created in your AWS account
}

resource "aws_eip" "minecraft_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.minecraft.id
  allocation_id = aws_eip.minecraft_eip.id
}

output "minecraft_server_eip" {
  value = aws_eip.minecraft_eip.public_ip
  description = "The public IP address of the Minecraft server"
}
