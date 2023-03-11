module "general_storage" {
  source      = "../../modules/storage"
  bucket_name = "serverlesshero-storage"
  bucket_tags = merge(var.common_tags)
}

module "catalog_lambda" {
  source             = "../../modules/lambda"
  function_name      = "catalog-lambda"
  function_handler   = "ServerlessHero.Lambdas.Catalog"
  s3_bucket_name     = "serverlesshero-releases"
  s3_key             = "lambdas/catalog-latest.zip"
  runtime            = "dotnet6"
  timeout_in_seconds = 180
}

module "gateway" {
  source               = "../../modules/apigateway"
  rest_api_name        = "catalog-api-gateway"
  lambda_invoke_arn    = module.catalog_lambda.lambda_invoke_arn
  lambda_arn           = module.catalog_lambda.lambda_arn
  lambda_function_name = module.catalog_lambda.lambda_function_name
  depends_on = [
    module.catalog_lambda
  ]
}

module "products_ddb_table" {
  source        = "../../modules/ddb"
  table_name    = "products"
  hash_key      = "id"
  hash_key_type = "N"
  json_location = "./data/products.json"
  tags          = merge(var.common_tags)
}


