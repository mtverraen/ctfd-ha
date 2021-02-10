terraform {
  required_providers {
    google      = "~> 3"
    google-beta = "~> 3"
    external    = "~> 1"
    helm        = "~> 1"
    kubernetes  = "~> 1"
    local       = "~> 1"
    null        = "~> 2"
    random      = "~> 2"
    template    = "~> 2"
    tls         = "~> 2"
  }
}

provider "google" {
  project = var.google_project
  region  = var.google_region
  zone    = var.google_zone
  credentials = "credentials.json"
}

provider "google-beta" {
  project = var.google_project
  region  = var.google_region
  zone    = var.google_zone
  credentials = "credentials.json"
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(google_container_cluster.apps.master_auth[0].cluster_ca_certificate)
  host                   = google_container_cluster.apps.endpoint
  token                  = data.google_client_config.current.access_token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(google_container_cluster.apps.master_auth[0].cluster_ca_certificate)
    host                   = google_container_cluster.apps.endpoint
    token                  = data.google_client_config.current.access_token
    load_config_file       = false
  }
}

data "google_client_config" "current" {}