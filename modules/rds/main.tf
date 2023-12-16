#Create database subnet group
resource "aws_db_subnet_group" "db-subnet" {
  name       = var.db_sub_group_name
  subnet_ids = [var.private_db_subnet_az1_id, var.private_db_subnet_az2_id]
}

# Create database
resource "aws_db_instance" "db" {
  identifier              = "bookdb-instance"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = true
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.db_sg_id] 

  db_subnet_group_name = aws_db_subnet_group.db-subnet.name

  tags = {
    Name = "bookdb"
  }
}