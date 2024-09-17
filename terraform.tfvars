aws_region  = "us-west-1"
environment = "dev"
app         = "galendu1"
# vpc_name    = "galendu-vpc"
vpc_cidr = "10.0.0.0/16"
# vpc_azs = ["ap-east-1a", "ap-east-1b","ap-east-1c"]
vpc_private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_enable_nat_gateway = true
vpc_tags = {
  Terraform = "true",
}

# # bucket name 
# bucket_name = "galendu-bucket"

# # key name
# key_name = "galendu-key"
# ssh-keygen -t rsa -b 4096 -C "galendu@foxmail.com" -f galendu-pub-key
# key_pub_file= "galendu-pub-key.pub"
# instance_name     = "galendu-app"
instance_count    = 2
ec2_instance_type = "t2.micro"
ami_id            = "ami-025258b26b492aec6"

#安全组配置
ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]