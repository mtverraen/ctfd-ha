resource "helm_release" "traefik" {
  name       = "traefik"
  chart      = "traefik"
  repository = "https://helm.traefik.io/traefik"
  namespace  = var.namespace
  timeout = 1800

  values = [
    data.template_file.traefik.rendered
  ]
}

data "template_file" "traefik" {
  template = file("${path.root}/config/traefik.yaml")
  vars = {}
}