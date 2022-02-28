

module "prometheus_stack" {
  source                   = "./modules/prometheus"
  external_dns_ingress_dns = var.domain

  namespace                  = kubernetes_namespace.monitoring.metadata[0].name
  prometheus_stack_namespace = "monitoring"
  grafana_password           = var.grafana_password

  depends_on = [
    kubernetes_namespace.monitoring,
    module.external_dns
  ]
}

module "prometheus-blackbox-exporter" {
  count                       = var.prometheus_blackbox_enabled ? 1 : 0
  source                      = "./modules/prometheus_blackbox_exporter"
  prometheus_blackbox_enabled = var.prometheus_blackbox_enabled
  prometheus_blackbox_targets = var.prometheus_blackbox_targets

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

