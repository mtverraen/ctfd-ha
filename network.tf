resource "google_compute_network" "blue_net" {
  name = "blue"
}

module "kong" {
  count              = var.kong_enabled ? 1 : 0
  source             = "./modules/kong"
  kong_chart_version = "2.7.0"
  kong_namespace     = kubernetes_namespace.kong[0].metadata[0].name
}