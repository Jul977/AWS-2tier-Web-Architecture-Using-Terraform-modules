#create vpc (referencing the module)
module "vpc" {
  source           = "../modules/vpc"
  project_name     = var.project_name
  region           = var.region
  vpc_cidr         = var.vpc_cidr
  pub_sub_az1_cidr = var.pub_sub_az1_cidr
  pub_sub_az2_cidr = var.pub_sub_az2_cidr
  pri_web_az1_cidr = var.pri_web_az1_cidr
  pri_web_az2_cidr = var.pri_web_az2_cidr
  pri_db_az1_cidr  = var.pri_db_az1_cidr
  pri_db_az2_cidr  = var.pri_db_az2_cidr
}

#create security groups (referencing the module)
module "sg" {
  source = "../modules/sg"
  vpc_id = module.vpc.vpc_id
}

#create nat gateway (referencing the module)
module "nat" {
  source                    = "../modules/nat"
  vpc_id                    = module.vpc.vpc_id
  public_subnet_az1_id      = module.vpc.public_subnet_az1_id
  public_subnet_az2_id      = module.vpc.public_subnet_az2_id
  private_web_subnet_az1_id = module.vpc.private_web_subnet_az1_id
  private_web_subnet_az2_id = module.vpc.private_web_subnet_az2_id
  private_db_subnet_az1_id  = module.vpc.private_db_subnet_az1_id
  private_db_subnet_az2_id  = module.vpc.private_db_subnet_az2_id
  internet_gateway          = module.vpc.internet_gateway
}

#create rds (referencing the module)
module "rds" {
  source                   = "../modules/rds"
  db_username              = var.db_username
  db_password              = var.db_password
  db_sg_id                 = module.sg.db_sg_id
  private_db_subnet_az1_id = module.vpc.private_db_subnet_az1_id
  private_db_subnet_az2_id = module.vpc.private_db_subnet_az2_id
}

#create ec2 key pair (referencing the module)
module "key" {
  source = "../modules/key"
}

#create auto-sg (referencing the module)
module "auto-sg" {
  source         = "../modules/auto-sg"
  project_name   = module.vpc.project_name
  key_name       = module.key.key_name
  client_sg_id   = module.sg.client_sg_id
  private_web_subnet_az1_id = module.vpc.private_web_subnet_az1_id
  private_web_subnet_az2_id = module.vpc.private_web_subnet_az2_id
  target_group_arn  = module.alb.target_group_arn

}

#create application load balancer (referencing the module)
module "alb" {
  source               = "../modules/alb"
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  alb_sg_id            = module.sg.alb_sg_id
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
}

# create cloud-front distribution (referencing the module)
module "cloud-front" {
  source                  = "../modules/cloud-front"
  certificate_domain_name = var.certificate_domain_name
  alb_domain_name         = module.alb.alb_dns_name
  additional_domain       = var.additional_domain
  project_name            = module.vpc.project_name
}

# Add record in route 53 hosted zone

module "route53" {
  source                    = "../modules/route53"
  cloudfront_domain_name    = module.cloud-front.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloud-front.cloudfront_hosted_zone_id

}