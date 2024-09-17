variable "name" {
  description = "key name"
  type        = string
}

# variable "tags" {
#   description = "Tags to set on the key."
#   type        = map(string)
#   default     = {}
# }

variable "key_pub_file" {
  type = string
}