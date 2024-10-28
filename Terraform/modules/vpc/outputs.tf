output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet_tags"{
  value = aws_subnet.public_subnet.tags
}

output "private_subnet_tags"{
  value = aws_subnet.private_subnet.tags
}

output "internet_gateway_tags"{
  value = aws_internet_gateway.igw.tags
}

output "vpc_cidr_block"{
  value = aws_vpc.main_vpc.cidr_block
}

output "public_subnet_cidr_block"{
  value = aws_subnet.public_subnet.cidr_block
}

output "private_subnet_cidr_block"{
  value = aws_subnet.private_subnet.cidr_block
}