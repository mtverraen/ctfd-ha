variable "root_user_password" {}
variable "db_user" {}
variable "db_password" {}
variable "namespace" {}
variable "metrics_enabled" {
  default = false
}
variable "db_name" {
  default = "ctfd"
}
variable "cluster_enabled" {
  default = true
}