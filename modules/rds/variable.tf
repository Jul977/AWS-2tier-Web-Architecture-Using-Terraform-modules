variable "db_username" {}
variable "db_password" {}
variable "db_sg_id" {}
variable "private_db_subnet_az1_id" {}
variable "private_db_subnet_az2_id" {}
variable "db_sub_group_name" {
    default = "jul_subnet_group"
}
variable "db_name" {
    default = "juldb"
}

