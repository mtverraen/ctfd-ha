data "template_file" "prometheus" {
  template = file("${path.root}/config/prometheus.yaml")
  vars = {
    external_dns_ingress_dns     = var.external_dns_ingress_dns
    alertmanager_tls_secret_name = "alertmanager-${replace("${var.external_dns_ingress_dns}", ".", "-")}-tls"

    grafana_tls_secret_name = "grafana-${replace("${var.external_dns_ingress_dns}", ".", "-")}-tls"

    prometheus_operator_create_crd = true
    prometheus_tls_secret_name     = "prometheus-${replace("${var.external_dns_ingress_dns}", ".", "-")}-tls"
  }
}

resource "helm_release" "prometheus_stack" {

  name       = var.release_name
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.prometheus_stack_version

  values = [
    data.template_file.prometheus.rendered
  ]

  set {
    name  = "grafana.adminPassword"
    value = var.grafana_password
  }
}

/*
resource "kubernetes_config_map" "grafana_dashboards" {
  metadata {
    name      = "grafana-dashboards"
    namespace  = var.namespace

    labels = {
      grafana_dashboard = "1"
    }
  }

  data = {
    "kong-dashboard.json" = file("${path.root}/modules/monitoring/dashboards/kong-dashboard.json")
    "ctfd-dashboard.json" = file("${path.root}/modules/monitoring/dashboards/ctfd-dashboard.json")
  }
}
*/

