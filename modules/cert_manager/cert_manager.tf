resource "helm_release" "cert_manager" {
  count = var.cert_manager_enabled ? 1 : 0

  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert_manager_chart_version
  namespace  = var.kubernetes_namespace
  timeout    = 1200

  set {
    name  = "installCRDs"
    value = true
  }

  set {
    name  = "ingressShim.defaultIssuerName"
    value = "letsencrypt"
  }
}

resource "helm_release" "letsencrypt" {
  count = var.cert_manager_enabled ? 1 : 0

  name       = "cert-manager-letsencrypt-issuer"
  chart      = "${path.root}/charts/letsencrypt/"
  namespace  = var.kubernetes_namespace
  timeout    = 1200
  depends_on = [helm_release.cert_manager]

  set {
    name  = "domain"
    value = "${var.domain}"
  }

  set {
    name  = "acme.http01.enabled"
    value = false
  }

  set {
    name  = "acme.dns01.enabled"
    value = true
  }

  set {
    name  = "acme.dns01.cloudflare.apiKey"
    value = var.cloudflare_api_token
  }
}