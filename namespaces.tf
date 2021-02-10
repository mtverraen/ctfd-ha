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
resource "kubernetes_namespace" "airflow_nfs" {
  metadata {
    labels = {
      name = "airflow-nfs"
    }

    name = "airfow-nfs"
  }
}
resource "kubernetes_namespace" "traefik" {
  metadata {
    labels = {
      name = "traefik"
    }

    name = "traefik"
  }
}