# 创建import块,并生成创建脚本
# aws help
# aws s3 help
# aws s3 ls
# terraform plan -generate-config-out=generated_resources.tf
# import {
#  # ID of the cloud resource
#  # Check provider documentation for importable resources and format
#  id = "galendu-test01"
#  # Resource address
#  to = aws_s3_bucket.this
# }

# import {
#  # ID of the cloud resource
#  # Check provider documentation for importable resources and format
#  id = "galendu-test02"
#  # Resource address
#  to = aws_s3_bucket.this2
# }