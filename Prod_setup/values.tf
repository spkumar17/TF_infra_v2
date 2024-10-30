module "Network" {
  source              = "../Modules/Network"
  vpc_cidr_block      = "10.0.0.0/16"
  vpc_name            = "Prodvpc"
  environment         = "Production"
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
  AZs                 = ["us-east-1a", "us-east-1b"]
  db_subnet_cidr      = ["10.0.30.0/24", "10.0.40.0/24"]

}

module "SecurityGroups" {
  source            = "../Modules/SecurityGroups"
  vpc_name          = module.Network.vpc_name
  vpc_id            = module.Network.vpc_id
  service_ports_elb = ["80", "8080", "443"]
  service_ports_asg = ["80", "8080", "443", "3306"]
  service_ports_rds = ["3306", "443", "80", "8080"]
  environment       = module.Network.environment
}

module "RDS" {
  database_name           = "Petclinic"
  source                  = "../Modules/RDS"
  allocated_storage       = "20"
  storage_type            = "gp3"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  engine_version          = "8.0"
  username                = "admin"
  password                = "Devops#21"
  backup_retention_period = "10"
  backup_window           = "00:00-03:00"
  maintenance_window      = "sun:05:00-sun:06:00"
  private_subnets         = module.Network.private_subnets
  rds                     = module.SecurityGroups.rds
  environment             = module.Network.environment
  db_subnets              = module.Network.database_subnets

}

module "ALB" {
  source         = "../Modules/ALB"
  vpc_name       = module.Network.vpc_name
  vpc_id         = module.Network.vpc_id
  alb            = module.SecurityGroups.elb
  public_subnets = module.Network.public_subnets
  environment    = module.Network.environment
}

module "ASG" {
  source                    = "../Modules/ASG"
  image_id                  = "ami-0866a3c8686eaeeba"
  instance_type             = "t2.micro"
  instance_name             = "mainservers"
  max_size                  = "4"
  min_size                  = "2"
  health_check_grace_period = "300"
  health_check_type         = "ELB"
  desired_capacity          = "2"
  key                       = "sshkey"
  asg                       = module.SecurityGroups.asg
  private_subnets           = module.Network.private_subnets
  aws_iam_instance_profile  = module.IAM.aws_iam_instance_profile
  vpc_name                  = module.Network.vpc_name
  db_instance_endpoint      = module.RDS.db_instance_endpoint
  alb_target_group_arn      = module.ALB.alb_target_group_arn
  database_name             = module.RDS.database_name
  username                  = module.RDS.username
  password                  = module.RDS.password
}

module "IAM" {
  source = "../Modules/IAM"

}

module "S3" {
  source      = "../Modules/S3"
  vpc_name    = module.Network.vpc_name
  environment = module.Network.environment


}

module "VPC_LOGS" {
  source      = "../Modules/VPC_LOGS"
  vpc_id      = module.Network.vpc_id
  environment = module.Network.environment
  bucket_name = module.S3.bucket_name
}

module "Route53" {
  source            = "../Modules/Route53"
  domain_name       = "cloudelevate.info"
  alternate_name    = "*.cloudelevate.info"
  load_balancer_arn = module.ALB.load_balancer_arn
  environment       = module.Network.environment


}
