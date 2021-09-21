provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "go-spot-instance"
  key_name = var.aws_key
  create_spot_instance = true
  spot_price           = "0.50"
  spot_type            = "persistent"

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  user_data              = "./run.sh"
  monitoring             = true
  vpc_security_group_ids = ["sg-05d97987ca947a1e1"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}