provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}



resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  name    = "${var.app}-vpc"
  cidr    = var.vpc_cidr

  azs                = data.aws_availability_zones.available.names
  private_subnets    = var.vpc_private_subnets
  public_subnets     = var.vpc_public_subnets
  enable_nat_gateway = var.vpc_enable_nat_gateway
  tags               = var.vpc_tags

}

module "kms_key" {
  source       = "./modules/kms-key"
  name         = "${var.app}-key"
  key_pub_file = ".key/${var.app}-pub-key.pub"
}

module "s3_web" {
  source = "./modules/s3-web"

  bucket_name = "${var.app}-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_security_group" "example" {
  name   = "${var.app}-instance-sg"
  vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

}

# 定义局部变量来保存实例名称
locals {
  instance_name = "${var.app}-instance-${var.environment}-${random_string.random.result}"
}

resource "aws_instance" "app_server" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.ec2_instance_type
  key_name      = module.kms_key.name

  subnet_id                   = module.vpc.public_subnets[count.index % length(module.vpc.public_subnets)]
  vpc_security_group_ids      = [aws_security_group.example.id]
  associate_public_ip_address = true

  tags = {
    Name = "${local.instance_name}+${count.index + 1}"
  }

  # 使用 templatefile 功能生成 user_data
  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    instance_name = "${local.instance_name}+${count.index + 1}"
  })
}
# 安装调试用的 SSH 公钥或其他配置
resource "null_resource" "command" {
  triggers = {
    private_key_md5 = md5(file(".key/${var.app}"))
  }
  count = var.instance_count
  provisioner "local-exec" {
    # command = "bash shell/pushs3.sh"
    command     = "pwd"
    interpreter = ["PowerShell", "-Command"]
  }


  provisioner "remote-exec" {
    inline = [
      "ps -ef",
      "cat /etc/hosts"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.app_server[count.index].public_ip
      private_key = file(".key/${var.app}")
    }
  }
  depends_on = [module.s3_web]

}

# terraform apply -auto-approve   -target="module.s3_web"  -target="null_resource.s3_op"
# terraform destroy -auto-approve   -target="module.s3_web"  -target="null_resource.s3_op"
resource "null_resource" "s3_op" {
  provisioner "local-exec" {
    when    = create
    command = "aws s3 cp modules/s3-web/www/ s3://${module.s3_web.name}/ --recursive"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "aws s3 rm  s3://${self.triggers.bucket_name}/ --recursive"
  }
  triggers = {
    bucket_name = module.s3_web.name # 将存储桶名称作为触发器存储
  }

  depends_on = [module.s3_web]
}

# import
# resource "aws_instance" "example" {
#   ami           = var.ami_id
#   instance_type = var.ec2_instance_type
#   key_name      = module.kms_key.name
#    tags = {
#     Name = "galendu"  # 替换为实例的实际标签
#   }
# }

#aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}"  --filters "Name=instance-state-name,Values=running" "Name=instance-type,Values='*'"     --output table --region us-west-1

#aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,id:InstanceId}" --filters "Name=instance-state-name,Values=running"   --output table --region us-west-1

# terraform import aws_instance.example <instance-id>
# aws ec2 describe-instances --instance-ids <instance-id> --region us-west-1