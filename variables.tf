variable "google_project" {}
variable "google_region" {}
variable "google_zone" {}
variable "storage_bucket" {}
variable "use_preemtible_nodes" {
  default = true
}
variable "machine_type" {
  default = "e2-medium"
}
#variable ceph_enabled {
#  default=false
#}

variable "cluster_name" {}
variable "root_domain" {}
variable "cert_manager_enabled" {}
variable "cloudflare_api_token" {}
variable "cloudflare_email" {}
variable "kong_enabled" {
  default = true
}
variable "grafana_password" {}
variable "prometheus_blackbox_enabled" {}
variable "prometheus_blackbox_targets" {}