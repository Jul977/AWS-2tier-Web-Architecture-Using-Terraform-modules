# Allocate Elastic IP. This EIP will be used for the nat-gateway in the public subnet az1 
resource "aws_eip" "eip_for_nat_gateway_az1" {
  vpc    = true

  tags   = {
    Name = "nat gateway az1 eip"
  }
}

# Allocate Elastic IP. This EIP will be used for the nat-gateway in the public subnet az2
resource "aws_eip" "eip_for_nat_gateway_az2" {
  vpc    = true

  tags   = {
    Name = "nat gateway az2 eip"
  }
} 

# Create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = var.public_subnet_az1_id

  tags   = {
    Name ="nat gateway az1"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.internet_gateway]
}

# Create nat gateway in public subnet az2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = var.public_subnet_az2_id

  tags   = {
    Name = "nat gateway az2"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.internet_gateway]
}

# Create private route table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az1.id
  }

  tags   = {
    Name = "private route table for az1"
  }
}

# Associate private web az1 subnet with private route table az1
resource "aws_route_table_association" "private_web_subnet_az1_route_table_association" {
  subnet_id         = var.private_web_subnet_az1_id
  route_table_id    = aws_route_table.private_route_table_az1.id
}

# Associate private db az1 subnet with private route table az1
resource "aws_route_table_association" "private_db_subnet_az1_route_table_association" {
  subnet_id         = var.private_db_subnet_az1_id
  route_table_id    = aws_route_table.private_route_table_az1.id
}

# Create private route table az2 and add route through nat gateway az2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az2.id
  }

  tags   = {
    Name = "private route table for az2"
  }
}

# Associate private web subnet az2 with private route table az2
resource "aws_route_table_association" "private_web_subnet_az2_route_table_association" {
  subnet_id         = var.private_web_subnet_az2_id
  route_table_id    = aws_route_table.private_route_table_az2.id
}

# Associate private db subnet az2 with private route table az2
resource "aws_route_table_association" "private_db_subnet_az2_route_table_association" {
  subnet_id         = var.private_db_subnet_az2_id
  route_table_id    = aws_route_table.private_route_table_az2.id
}