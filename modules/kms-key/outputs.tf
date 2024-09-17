output "name" {
  description = "Name (id) of the key"
  value       = aws_key_pair.kms_example.key_name
}

output "kms_key_id" {
  value = aws_key_pair.kms_example.id
}

output "path" {
  value = aws_key_pair.kms_example.public_key
}