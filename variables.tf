variable "google_project" {}
variable "google_region" {}
variable "google_zone" {}
variable "storage_bucket" {}

variable "use_preemtible_nodes"{
  default=true
}
variable "machine_images" {
  default="e2-medium"
}
variable "cluster_name"{}