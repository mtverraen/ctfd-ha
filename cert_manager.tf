module "external_dns" {

  source     = "./modules/external_dns"
  cluster_id = google_container_node_pool.apps.name

  external_dns_id            = "gke"
  external_dns_project       = var.google_project
  external_dns_chart_version = "2.22.1"
  kubernetes_namespace = kubernetes_namespace.external_dns.metadata.0.name
  cloudflare_email   = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_token
  domain = var.domain
  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps
  ]
}

module "cert_manager" {
  source = "./modules/cert_manager"

  cluster_id = google_container_node_pool.apps.name
  
  cert_manager_enabled       = var.cert_manager_enabled
  cert_manager_id            = "gke"
  cert_manager_project       = var.google_project
  cert_manager_chart_version = "v0.15.0-beta.1"
  
  kubernetes_namespace = kubernetes_namespace.cert_manager.metadata.0.name

  cloudflare_api_token = var.cloudflare_api_token
  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps,
  ]
}