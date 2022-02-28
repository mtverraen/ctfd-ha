resource "google_filestore_instance" "filestore" {
  provider = google-beta
  name = "ctfd"
  zone = "europe-west1-b"
  tier = "BASIC_HDD"

  file_shares {
    capacity_gb = 1024
    name        = "share1"

    nfs_export_options {
      ip_ranges = ["10.0.0.0/24","10.132.0.0/20"]
      access_mode = "READ_WRITE"
      squash_mode = "NO_ROOT_SQUASH"
   }
  }
  networks {
    network = "default"
    modes   = ["MODE_IPV4"]
  }
}

resource "kubernetes_persistent_volume_claim" "example" {
  metadata {
    name = "ctfd"
    namespace = kubernetes_namespace.ctfd.metadata.0.name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "100Gi"
      }
    }
    volume_name = "${kubernetes_persistent_volume.example.metadata.0.name}"
  }
  depends_on = [ kubernetes_namespace.ctfd ]
}

resource "kubernetes_persistent_volume" "example" {
  metadata {
    name = "fileserver"
  }
  spec {
    capacity = {
      storage = "1T"
    }
    access_modes = ["ReadWriteMany"]
    storage_class_name = "standard"
    persistent_volume_source {
      nfs {
          path = "/share1"
          server= google_filestore_instance.filestore.networks.0.ip_addresses.0
      }
    }
  }
}