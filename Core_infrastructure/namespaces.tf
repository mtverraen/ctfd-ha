resource "kubernetes_namespace" "ctfd" {

  metadata {
    name = "core"
    labels = {
      name = "core"
    }

  }
}
/*
resource "kubernetes_namespace" "kong" {
  count = var.kong_enabled ? 1 : 0
  metadata {
    labels = {
      name = "kong"
    }
    name = "kong"
  }
}
*/

resource "kubernetes_namespace" "external_dns" {
  metadata {
    annotations = {
      name = "external-dns"
    }

    name = "external-dns"
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    annotations = {
      name = "cert-manager"
    }

    name = "cert-manager"
  }
}


resource "kubernetes_namespace" "monitoring" {
  metadata {
    labels = {
      name = "monitoring"
    }

    name = "monitoring"
  }
}