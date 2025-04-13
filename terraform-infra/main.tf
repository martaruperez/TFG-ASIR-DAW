module "vpc" {
  source = "./000-VPC-y-subredes"
}

module "alb" {
  source           = "./010-ALB"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "asg" {
  source           = "./020-ec2-ASG"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  nat_instance_id  = module.vpc.nat_instance_id
}