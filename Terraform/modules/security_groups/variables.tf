variable "vpc_id" {
  description = "ID of the VPC"
}

variable "public_ec2_sg_id" {
  description = "ID of the security group for public EC2 instance"
}

variable "allowed_ip" {
  description = "Allowed IP for SSH access to Public EC2"
}
