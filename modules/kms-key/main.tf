resource "aws_key_pair" "kms_example" {
  key_name = var.name
  public_key = file(var.key_pub_file) # 指定公钥文件路径
  
}