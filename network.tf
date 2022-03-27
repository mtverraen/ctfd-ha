resource "google_compute_network" "blue_net" {
  name = "blue"
}

module "nginx" {
  source             = "./modules/nginx"
  nginx_chart_version = "4.0.18"
  nginx_namespace     = kubernetes_namespace.nginx.metadata[0].name
}

