resource "helm_release" "prometheus_black_box_exporter" {
  count = var.prometheus_blackbox_enabled ? 1 : 0

  name       = var.release_name
  namespace  = var.prometheus_blackbox_exporter_namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  version    = var.prometheus_black_box_exporter_version

  values = [
    data.template_file.blackbox_exporter.rendered
  ]

}

data "template_file" "blackbox_exporter" {
  template = file("${path.module}/blackbox-exporter.yaml")
  vars = {
    targets = yamlencode(tolist((var.prometheus_blackbox_targets)))
  }
}
