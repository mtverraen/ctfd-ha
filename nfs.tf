/*
module "airflow_nfs" {
  source  = "kiwicom/gke-nfs/kubernetes"
  version = "0.1.0"

  name      = "airflow"
  namespace = kubernetes_namespace.ctfd.metadata.0.name
  zones     = ["europe-west1-b", "europe-west1-c"]

  volumes = {
    "uploads" = 10
  }
}*/