module "general_storage" {
  source      = "../../modules/storage"
  bucket_name = "serverlesshero-storage"
  bucket_tags = merge(var.common_tags)
}
