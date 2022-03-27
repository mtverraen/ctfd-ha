resource "helm_release" "ctfd" {
  name      = "ctfd"
  chart     = "${path.root}/charts/ctfd"
  timeout   = 600
  namespace = var.namespace
  values = [
    data.template_file.ctfd.rendered
  ]
}

data "template_file" "ctfd" {
  template = file("${path.module}/ctfd.yaml")
  vars = {
    ctfd_domain               = "ctf.${var.domain}"
    replica_count             = 2
    image_tag                 = var.imageTag 
    env_open_amt_workers      = 3
    env_open_secret_key       = random_string.ctfd_secret_key.result
    env_open_database_uri     = "mysql+pymysql://root:${var.mariadb_password}@${var.mariadb_address}/ctfd"
    env_open_redis_uri        = "redis://:${var.redis_password}@redis-cache-master:6379"
    service_monitor_namespace = var.namespace

    ctfd_tls_secret_name = "ctf-${replace("${var.domain}", ".", "-")}-tls"
  }
}

resource "random_string" "ctfd_secret_key" {
  length           = 16
  special          = false
  override_special = "/@£$"
}