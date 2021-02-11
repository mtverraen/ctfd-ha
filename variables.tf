variable "google_project" {}
variable "google_region" {}
variable "google_zone" {}
variable "storage_bucket" {}
variable "cluster_name" {}
variable "node_pool_name" {}
variable "domain" {}
variable "cloudflare_email" {}
variable "cloudflare_api_token" {}
variable "cloudflare_zone_id" {}
variable "cert_manager_enabled" {
  default = "false"
}

variable "grafana_password" {}

# Prometheus blackbox exporter
variable "prometheus_blackbox_enabled" {
  default = false
}
variable "kong_enabled" {
  default = true
}
/*
prometheus_blackbox_targets = [
  { name : "target1", url : "https://10.10.10.10:6443/" },
  { name : "target2", url : "https://10.10.10.11:6443/" }
]
*/
variable "prometheus_blackbox_targets" {}