module "vpc" {
  source = "./000-VPC-y-subredes"
}

module "alb" {
  source = "./010-ALB"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "asg" {
  source = "./020-ec2-ASG"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_group_arn = module.alb.target_group_arn
  alb_sg_id = module.alb.alb_sg_id
}