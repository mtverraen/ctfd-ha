# namespace

data "template_file" "kong" {
  template = file("${path.root}/config/kong.yaml")
}

resource "helm_release" "kong" {

  name       = "kong"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  version    = var.kong_chart_version
  namespace  = var.kong_namespace

  values = [
    data.template_file.kong.rendered
  ]
}

resource "helm_release" "kong_prometheus_plugin" {

  name       = "kong-prometheus-plugin"
  chart      = "${path.root}/charts/kong-cluster-plugins"
  version    = "0.1.0"
  namespace  = var.kong_namespace

  set {
    name  = "prometheus.enabled"
    value = true
  }
}

