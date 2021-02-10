module "traefik" {
  source = "./modules/traefik"
  depends_on = [
    kubernetes_namespace.traefik
  ]
}