module "general_storage" {
  source      = "../../modules/storage"
  bucket_name = "serverlesshero-storage"
  bucket_tags = merge(var.common_tags)
}

module "catalog_lambda" {
  source           = "../../modules/lambda"
  function_name    = "catalog-lambda"
  function_handler = "ServerlessHero.Lambdas.Catalog"
  s3_bucket_name   = "serverlesshero-releases"
  s3_key           = "lambdas/catalog-latest.zip"
  runtime          = "dotnet6"
}
