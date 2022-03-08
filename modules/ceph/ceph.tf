resource "helm_release" "ceph_operator" {
  name       = "ceph-operator"
  repository = "https://charts.rook.io/release"
  chart      = "rook-ceph"
  namespace  = var.ceph_namespace
  version    = var.ceph_chart_version
  timeout    = 1200

  values = [
    data.template_file.ceph_operator.rendered
  ]
}

data "template_file" "rook_ceph" {
  template = file("${path.module}/rook_ceph_cluster.yaml")
}

data "template_file" "ceph_operator" {
  template = file("${path.module}/ceph_operator.yaml")
}

resource "helm_release" "rook_ceph_cluster" {
  name       = "rook-ceph-cluster"
  repository = "https://charts.rook.io/release"
  chart      = "rook-ceph-cluster"
  namespace  = var.ceph_namespace
  version    = var.ceph_chart_version
  timeout    = 1200

  values = [
    data.template_file.rook_ceph.rendered
  ]
  depends_on = [helm_release.ceph_operator]
}
