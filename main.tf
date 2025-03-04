provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "win_sg" {
  name        = "windows_security_group"
  description = "Permite RDP e WINRM"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5986
    to_port     = 5986
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

resource "aws_instance" "windows_server" {
  ami           = "ami-0b2f6494ff0b07a0e" 
  instance_type = "t2.micro"
  key_name      = "#####-MINHA_CHAVE-#####"
  security_groups = [aws_security_group.win_sg.name]

  tags = {
    Name = "WindowsServer2019"
  }
}

output "public_ip" {
  value = aws_instance.windows_server.public_ip
}
