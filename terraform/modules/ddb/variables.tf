variable "table_name" {
  type    = string
  default = null
}

variable "hash_key" {
  type    = string
  default = null
}

variable "hash_key_type" {
  type    = string
  default = null
}

variable "json_location" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
}
