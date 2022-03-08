resource "helm_release" "redis" {
  name       = "redis-cache"
  chart      = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = var.namespace

  set {
    name  = "cluster.enabled"
    value = var.cluster_enabled
  }
  set {
    name  = "auth.password"
    value = var.redis_password
  }

  timeout = 1800
}