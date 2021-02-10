module "traefik" {
  source = "./modules/traefik"
  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps,
    kubernetes_namespace.traefik
  ]
}