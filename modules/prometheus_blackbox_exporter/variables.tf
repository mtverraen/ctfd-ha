variable "prometheus_black_box_exporter_version" {
  default = "5.4.1"
}

variable "release_name" {
  default = "prometheus-blackbox-exporter"
}

variable "prometheus_blackbox_exporter_namespace" {
  default = "monitoring"
}

variable "prometheus_blackbox_enabled" {
  default = false
}

variable "prometheus_blackbox_targets" {}