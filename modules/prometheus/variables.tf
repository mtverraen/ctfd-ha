variable "prometheus_stack_namespace" {}

variable "release_name" {
  default = "kube-prometheus-stack"
}

variable "prometheus_stack_version" {
  default = "13.4.1"
}

variable "grafana_password" {}

variable "external_dns_ingress_dns" {}

variable "namespace" {}