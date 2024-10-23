# Security Group for Public EC2 (Allow SSH from specific IP)
resource "aws_security_group" "public_ec2_sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "PublicEC2SecurityGroup_lab_1"
  }
}

# Security Group for Private EC2 (Allow SSH only from Public EC2)
resource "aws_security_group" "private_ec2_sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "PrivateEC2SecurityGroup_lab_1"
  }
}

#Inbound rule for Public EC2 (Allow SSH from EC2 Instance Connect)
resource "aws_security_group_rule" "inbound_rule_public_ec2_sg" {
  security_group_id = aws_security_group.public_ec2_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  prefix_list_ids = ["pl-073f7512b7b9a2450"]
  description = "Allow SSH from EC2 Instance Connect"
  
}

#Outbound rule for Public EC2 (Allow all outbound traffic)
resource "aws_security_group_rule" "outbound_rule_public_ec2_sg" {
  security_group_id = aws_security_group.public_ec2_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description = "Allow all outbound traffic"
}

#Inbound rule for Private EC2 (Allow SSH from Public EC2)
resource "aws_security_group_rule" "inbound_rule_private_ec2_sg" {
  security_group_id = aws_security_group.private_ec2_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.public_ec2_sg_id
  description = "Allow SSH from Public EC2"
}

#Outbound rule for Private EC2 (Allow all outbound traffic)
resource "aws_security_group_rule" "outbound_rule_private_ec2_sg" {
  security_group_id = aws_security_group.private_ec2_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description = "Allow all outbound traffic"
}