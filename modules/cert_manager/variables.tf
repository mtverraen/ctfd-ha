variable "kubernetes_namespace" {}
variable "cluster_id" {}
variable "cert_manager_enabled" {}
variable "cert_manager_id" {}
variable "cert_manager_project" {}
variable "cert_manager_chart_version" {}
variable "cert_manager_namespace" {
  default = "external-dns"
}
variable "domain" {}
variable "cloudflare_api_token" {}