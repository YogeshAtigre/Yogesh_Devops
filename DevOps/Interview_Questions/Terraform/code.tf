resource "aws_instance" "web-server" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name = "your-key-name"
  tags = {
    Name = "Rough code"
  }
}

resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Rough Code vpc"
    }
  
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1"
  map_public_ip_on_launch = true
  tags = {
    Name = "Rough code subnet"
  }
}


resource "aws_s3_bucket" "storage_bucket" {
    bucket = "name-of-bucket-that-will-created"
    acl = "private"
    tags = {
      Name = "Rough code bucket"
    }
  
}


resource "aws_security_group" "web-security-group" {
  name = "name-of-security-group-that-will-created"
  vpc_id = aws_vpc.main_vpc.id
  description = "Allow SSH , TCP and HTTP Connections"

  ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-security-group"
  }
}


resource "aws_iam_role" "custome-role" {
    name = "custome-role"
    assume_role_policy = jsondecode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssusmeRole"
                Effect = "Allow"
                Principal = {
                    Service  = "ec2.amazonaws.com"
                }
            }
        ]
    })
}


##################################################################################################

