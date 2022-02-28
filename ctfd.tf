module "ctfd" {
  source        = "./modules/ctfd"
  imageTag      = "3.4.0"
  replica_count = "2"
  workers       = "5"
  namespace     = kubernetes_namespace.ctfd.metadata.0.name
  domain        = var.domain
  #ctfd_secret_key  = var.ctfd_secret_key
  mariadb_address  = "maria-db-mariadb"
  mariadb_password = random_string.maria_root_db_password.result
  redis_address    = "redis-master"
  redis_password   = random_string.redis_password.result

  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps,
    module.redis,
    module.mariadb,
    kubernetes_persistent_volume_claim.example
  ]
}