provider "aws" {
  region = "ap-southeast-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block     = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone = "ap-southeast-1a"
}

module "route_table" {
  source = "./modules/route_table"

  vpc_id = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id = module.nat_gateway.nat_gateway_id

  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

}

module "nat_gateway" {
  source = "./modules/nat_gateway"

  public_subnet_id = module.vpc.public_subnet_id
}

module "ec2_instances" {
  source = "./modules/ec2_instances"

  ami               = "ami-047126e50991d067b"
  instance_type     = "t2.micro"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  public_ec2_sg_id  = module.security_groups.public_ec2_sg_id
  private_ec2_sg_id = module.security_groups.private_ec2_sg_id
  key_pair          = "Lab 1"
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id         = module.vpc.vpc_id
  allowed_ip     = "0.0.0.0/0"
  public_ec2_sg_id = module.security_groups.public_ec2_sg_id
}
