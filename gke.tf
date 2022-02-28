
resource "google_container_cluster" "core" {
  provider = google-beta
  name     = var.cluster_name
  location = var.google_zone
  network = google_compute_network.blue_net
  # Configuration options for the Release channel feature, which provide more
  # control over automatic upgrades of your GKE clusters. When updating this
  # field, GKE imposes specific version requirements.
  release_channel {
    channel = "REGULAR"
  }  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # The maintenance policy to use for the cluster.
  maintenance_policy {
    daily_maintenance_window {
    start_time = "03:00"
    }
  }
  # Workload Identity allows Kubernetes service accounts to act as a
  # user-managed Google IAM Service Account.
  workload_identity_config {
    identity_namespace = "${var.google_project}.svc.id.goog"
  }

  network_policy {
    enabled = true 
  }

  addons_config {
    network_policy_config {
      disabled=false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.cluster_name}-nodepool"
  location   = var.google_zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = var.use_preemtible_nodes
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}