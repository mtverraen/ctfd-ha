variable "prometheus_stack_namespace" {}

variable "release_name" {
  default = "kube-prometheus-stack"
}

variable "prometheus_stack_version" {
  default = "33.1.0"
}

variable "grafana_password" {}

variable "external_dns_ingress_dns" {}

variable "namespace" {}