output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.pub_sub_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.pub_sub_az2.id
}

output "private_web_subnet_az1_id" {
  value = aws_subnet.pri_web_az1.id
}

output "private_web_subnet_az2_id" {
  value = aws_subnet.pri_web_az2.id
}

output "private_db_subnet_az1_id" {
  value = aws_subnet.pri_db_az1.id
}

output "private_db_subnet_az2_id" {
  value = aws_subnet.pri_db_az2.id
}

output "internet_gateway"{
    value = aws_internet_gateway.igw
}
