module "external_dns" {

  source     = "./modules/external_dns"
  cluster_id = google_container_node_pool.apps.name

  external_dns_id            = "gke"
  external_dns_project       = var.google_project
  external_dns_chart_version = "6.1.7"
  kubernetes_namespace       = kubernetes_namespace.external_dns.metadata.0.name
  cloudflare_email           = var.cloudflare_email
  cloudflare_api_key         = var.cloudflare_api_token
  domain                     = var.root_domain
}

module "cert_manager" {
  source = "./modules/cert_manager"

  cluster_id = google_container_node_pool.primary.name

  cert_manager_enabled       = var.cert_manager_enabled
  cert_manager_id            = "gke"
  cert_manager_project       = var.google_project
  cert_manager_chart_version = "0.4.6"
  domain                     = var.root_domain
  kubernetes_namespace       = kubernetes_namespace.cert_manager.metadata.0.name

  cloudflare_api_token = var.cloudflare_api_token
}