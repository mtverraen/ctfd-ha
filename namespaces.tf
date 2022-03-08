resource "kubernetes_namespace" "ctfd" {

  metadata {
    name = "core"
    labels = {
      name = "core"
    }

  }
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary
  ]
}
/*
resource kubernetes_namespace "rook_ceph" {
  count              = var.ceph_enabled ? 1 : 0
  metadata {
    labels = {
      name = "rook-ceph"
    }
    name = "rook-ceph"
  }
  
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary
  ]
}
*/
resource "kubernetes_namespace" "kong" {
  count = var.kong_enabled ? 1 : 0
  metadata {
    labels = {
      name = "kong"
    }
    name = "kong"
  }
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary
  ]
}

resource "kubernetes_namespace" "external_dns" {
  metadata {
    annotations = {
      name = "external-dns"
    }

    name = "external-dns"
  }
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary
  ]
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    annotations = {
      name = "cert-manager"
    }

    name = "cert-manager"
  }
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary
  ]
}


resource "kubernetes_namespace" "monitoring" {
  metadata {
    labels = {
      name = "monitoring"
    }

    name = "monitoring"
  }
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary
  ]
}