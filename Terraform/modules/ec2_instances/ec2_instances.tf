# Public EC2 Instance
resource "aws_instance" "public_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  security_groups = [var.public_ec2_sg_id]
  associate_public_ip_address = true
  key_name = var.key_pair

  tags = {
    Name = "PublicInstance_lab_1"
  }
}

# Private EC2 Instance
resource "aws_instance" "private_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = [var.private_ec2_sg_id]

  key_name = var.key_pair

  tags = {
    Name = "PrivateInstance_lab_1"
  }
}
