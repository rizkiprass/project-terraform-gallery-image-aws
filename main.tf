module "vpc" {
  source = "./modules/vpc"

  name               = "gallery"
  env                = "dev"
  cidr               = "10.0.0.0/16"
  public_subnet_az1  = "10.0.0.0/24"
  public_subnet_az2  = "10.0.1.0/24"
  private_subnet_az1 = "10.0.2.0/24"
  private_subnet_az2 = "10.0.3.0/24"
  data_subnet_az1    = "10.0.4.0/24"
  data_subnet_az2    = "10.0.5.0/24"
}

#module "ec2-openvpn" {
#  source = "rizkiprass/ec2-openvpn-as/aws"
#
#  name                          = "openvpn"
#  create_ami                    = true #ubuntu 20
#  create_vpc_security_group_ids = true
#  instance_type                 = "t3.micro"
#  vpc_id                        = module.vpc.vpc_id
#  ec2_subnet_id                 = module.vpc.public_subnet_ids[0]
#  user_openvpn                  = "user-1"
#  routing_ip                    = "10.0.0.0/16" #Your VPC CIDR
#  iam_instance_profile          = module.iam.ssm_core_instance_profile_name
#
#  tags = {
#    Terraform = "Yes"
#  }
#}

module "ec2_frontend" {
  source = "./modules/ec2"

  prefix_name          = "gallery"
  name                 = "fe"
  env                  = "dev"
  ami                  = data.aws_ami.ubuntu_20.id
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_id    = [module.security_group.web_security_group_id]
  associate_public_ip  = true
  user_data            = file("./scripts/install_node.sh")
  iam_instance_profile = module.iam.ssm_core_instance_profile_name
}

module "ec2_backend" {
  source = "./modules/ec2"

  prefix_name          = "gallery"
  name                 = "be"
  env                  = "dev"
  ami                  = data.aws_ami.ubuntu_20.id
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_id    = [module.security_group.app_security_group_id]
  associate_public_ip  = true
  user_data            = file("./scripts/install_node.sh")
  iam_instance_profile = module.iam.ssm_core_instance_profile_name
}

module "ec2_db" {
  source = "./modules/ec2"

  prefix_name          = "gallery"
  name                 = "db"
  env                  = "dev"
  ami                  = data.aws_ami.ubuntu_20.id
  instance_type        = "t3.medium"
  subnet_id            = module.vpc.data_subnet_ids[0]
  security_group_id    = [module.security_group.db_security_group_id]
  user_data            = file("./scripts/install_mysql_ubuntu20.sh")
  iam_instance_profile = module.iam.ssm_core_instance_profile_name
}

module "security_group" {
  source = "./modules/security_group"

  name   = "gallery"
  vpc_id = module.vpc.vpc_id
  cidr   = "10.0.0.0/16"

  #ALB-SG
  description_alb = "alb security group"
  #  alb-port-list   = {}

  #APP-SG
  description_app = "app security group"
  application-port-list = {
    "tcp" = 8081
  }

  #WEB-SG
  description_web = "web security group"
  web-port-list = {
    "http"  = 80
    "https" = 443
  }

  #MYSQL-SG
  description_db = "db security group"




}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"

  name = "gal-aws-432"
  env  = "dev"
}

data "aws_ami" "ubuntu_20" {
  most_recent = true
  owners      = ["099720109477"] # Canonical account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}