
resource "helm_release" "external_dns" {
  count = var.external_dns_enabled ? 1 : 0

  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = var.external_dns_chart_version
  namespace  = var.external_dns_namespace
  timeout    = 600


  /*
  set {
      name="domains[1]"
      value="*.ctf.${var.domain}"
  }
  */
  set {
    name  = "policy"
    value = "upsert-only"
  }
  set {
    name  = "domains"
    value = "upsert-only"
  }

  set {
    name  = "source"
    value = "ingress"
  }

  set {
    name  = "provider"
    value = "cloudflare"
  }

  set {
    name  = "cloudflare.apiToken"
    value = var.cloudflare_api_key
  }
  set {
    name  = "cloudflare.email"
    value = var.cloudflare_email
  }
  set {
    name  = "cloudflare.proxied"
    value = false
  }
}