module "ctfd" {
  source        = "./modules/ctfd"
  imageTag      = "3.4.0"
  replica_count = "2"
  workers       = "5"
  namespace     = kubernetes_namespace.ctfd.metadata.0.name
  domain        = var.root_domain
  #ctfd_secret_key  = var.ctfd_secret_key
  mariadb_address  = "maria-db-mariadb"
  mariadb_password = random_string.maria_root_db_password.result
  redis_address    = "redis-master"
  redis_password   = random_string.redis_password.result

  depends_on = [
    module.redis,
    module.mariadb,
    //kubernetes_persistent_volume_claim.example
  ]
}