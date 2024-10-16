variable "ami" {
  description = "AMI ID for EC2 instances"
}

variable "instance_type" {
  description = "Instance type for EC2"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
}

variable "public_ec2_sg_id" {
  description = "ID of the security group for public EC2 instance"
}

variable "private_ec2_sg_id" {
  description = "ID of the security group for private EC2 instance"
}

variable "key_pair" {
  description = "Key pair for SSH access"
}
