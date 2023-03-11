resource "aws_dynamodb_table" "table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key
  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }
  tags = var.tags
}


resource "aws_dynamodb_table_item" "table_item" {
  for_each   = local.tf_data
  table_name = aws_dynamodb_table.table.name
  hash_key   = aws_dynamodb_table.table.hash_key
  item       = jsonencode(each.value)
  depends_on = [
    aws_dynamodb_table.table
  ]
}
