resource "kubernetes_namespace" "ctfd" {

  metadata {
    name = "core"
    labels = {
      name = "core"
    }

  }
  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps
  ]
}

resource "kubernetes_namespace" "kong" {
  count = var.kong_enabled ? 1 : 0
  metadata {
    labels = {
      name = "kong"
    }
    name = "kong"
  }
  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps
  ]
}


resource "kubernetes_namespace" "challenges" {

  metadata {
    name = "challenges"
    labels = {
      name = "challenges"
    }

  }
  depends_on = [
    google_container_cluster.apps,
    google_container_node_pool.apps
  ]
}

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