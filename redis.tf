module "redis" {
  source         = "./modules/redis"
  namespace      = kubernetes_namespace.ctfd.metadata.0.name
  redis_password = random_string.redis_password.result
}

resource "random_string" "redis_password" {
  length           = 32
  special          = false
  override_special = "/@£$"
}