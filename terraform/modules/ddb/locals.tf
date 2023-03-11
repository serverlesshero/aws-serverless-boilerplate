locals {
  json_data = (var.json_location == null) ? null : file(var.json_location)
  tf_data   = (local.json_data == null) ? {} : jsondecode(local.json_data)
}
