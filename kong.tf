

module "kong" {
  count = var.kong_enabled ? 1 : 0
  source             = "./modules/kong"
  kong_chart_version = "1.8.0"
  kong_namespace     = kubernetes_namespace.kong[0].metadata[0].name
  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps
  ]
}

