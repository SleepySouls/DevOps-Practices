# Định nghĩa region AWS để tạo tài nguyên (ap-southeast-1 - Asia Pacific/Singapore)
provider "aws" {
  region = "ap-southeast-1"
}

# Định nghĩa module VPC
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16" # CIDR block cho VPC
  public_subnet_cidr = "10.0.1.0/24" # CIDR block cho subnet public
  private_subnet_cidr = "10.0.2.0/24" # CIDR block cho subnet private
  availability_zone = "ap-southeast-1a"
}

# Định nghĩa module route table
module "route_table" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id # Link route table với VPC đã tạo
  internet_gateway_id = module.vpc.internet_gateway_id # Cổng Internet cho subnet public
  nat_gateway_id = module.nat_gateway.nat_gateway_id # NAT Gateway cho subnet private
  public_subnet_id = module.vpc.public_subnet_id # ID của subnet public
  private_subnet_id = module.vpc.private_subnet_id # ID của subnet private
}

# Định nghĩa module NAT Gateway
module "nat_gateway" {
  source = "./modules/nat_gateway"
  public_subnet_id = module.vpc.public_subnet_id
  # NAT Gateway sẽ được tạo trong subnet public
}

# Định nghĩa module EC2 Instance
module "ec2_instances" {
  source = "./modules/ec2_instances"
  ami               = "ami-047126e50991d067b" # ID của AMI của EC2
  instance_type     = "t2.micro" # Loại/Kích thước EC2 instance
  public_subnet_id  = module.vpc.public_subnet_id # EC2 public sẽ nằm trong subnet public
  private_subnet_id = module.vpc.private_subnet_id # EC2 private sẽ nằm trong subnet private
  public_ec2_sg_id  = module.security_groups.public_ec2_sg_id # ID của Security Group cho EC2 public
  private_ec2_sg_id = module.security_groups.private_ec2_sg_id # ID của Security Group cho EC2 private
  key_pair          = "Lab 1" # Khóa SSH EC2
}

# Định nghĩa module Security Group
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id         = module.vpc.vpc_id # Liên kết Security Group với VPC
  allowed_ip     = "0.0.0.0/0" # Dải IP được phép truy cập (0.0.0.0 - toàn bộ IP có thể truy cập)
  public_ec2_sg_id = module.security_groups.public_ec2_sg_id # ID của Security Group cho EC2 public
}
