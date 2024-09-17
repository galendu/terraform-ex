variable "aws_region" {
  type        = string
  description = "description"
}

variable "environment" {
  type        = string
  description = "description"
}

variable "app" {
  type        = string
  description = "app 名字"
}

# variable "key_pub_file" {
#   type = string
# }
#vpc 环境变量
# variable "vpc_name" {
#   type        = string
#   description = "vpc name"
# }

variable "vpc_cidr" {
  type        = string
  description = "vpc_cidr"
}

# variable "vpc_azs" {
#   type        = list(string)
#   description = "description"
# }

variable "vpc_private_subnets" {
  type        = list(string)
  description = "description"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "description"
}

variable "vpc_enable_nat_gateway" {
  type        = bool
  description = "description"
}

variable "vpc_tags" {
  type        = map(string)
  description = "vpc tags"
}

# s3

# variable "bucket_name" {
#   type = string
#   description = "bucket name"
# }

# instance

# variable "instance_name" {
#   type        = string
#   description = "description"
# }

variable "instance_count" {
  type        = number
  description = "ec2 instance count"
}


variable "ec2_instance_type" {
  description = "AWS EC2 instance type."
  type        = string
}

# variable "filter_name" {
#   type        = string
#   description = "description"
# }

variable "ami_id" {
  type        = string
  description = "description"
}

#使用 list(object({})) 类型可以让你在 Terraform 中管理和操作复杂的数据结构，如安全组规则、多个资源配置等，这种方式有助于提高配置的灵活性和可维护性
variable "ingress_rules" {
  description = "ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    # ipv6_cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
