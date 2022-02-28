module "redis" {
  source         = "./modules/redis"
  namespace      = kubernetes_namespace.ctfd.metadata.0.name
  redis_password = random_string.redis_password.result


  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps
  ]
}

resource "random_string" "redis_password" {
  length           = 32
  special          = false
  override_special = "/@£$"
}