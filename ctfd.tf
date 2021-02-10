module "ctfd" {
  source        = "./modules/ctfd"
  imageTag      = "mark-3.1.1"
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
    module.external_dns,
    module.prometheus_stack,
    module.redis,
    module.mariadb,
    module.airflow_nfs
  ]
}
