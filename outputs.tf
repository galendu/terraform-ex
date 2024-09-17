output "instance_name" {
  # for列表推导式,通过[for ...] 遍历 aws_instance.app_server 中的每个实例，获取每个实例的 tags.Name 值
  value = [for instance in aws_instance.app_server : instance.tags.Name]
}

output "app_service_urls" {
  value = {
    for inst in aws_instance.app_server : inst.tags.Name => inst.public_dns
  }
}
# Outputs: 

# instance_name = [
#   "galendu-app-dev-n4d6-1",
#   "galendu-app-dev-n4d6-2",
# ]

output "aws_security_group" {
  value = aws_security_group.example.name
}

output "aws_key_pair" {
  value = module.kms_key.name
}
output "aws_key_path" {
  value = module.kms_key.path
}

output "aws_s3_bucket" {
  value = module.s3_web.name
}