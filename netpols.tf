resource "kubernetes_network_policy" "mariadb" {
  metadata {
    name      = "mariadb-ingress-policy"
    namespace = "ctfd"
  }

  spec {
    pod_selector {
      match_expressions {
        key      = "name"
        operator = "In"
        values   = ["mariadb"]
      }
    }

    ingress {
      ports {
        port     = "3306"
        protocol = "TCP"
      }

      from {
        pod_selector {
          match_labels = {
            name = "name"
            operator = "In"
            value = "ctfd"
          }
        }
      }
    }
  egress {} # single empty rule to allow all egress traffic
  policy_types = ["Ingress", "Egress"]
  }
  depends_on = [kubernetes_namespace.ctfd]
}

resource "kubernetes_network_policy" "redis" {
  metadata {
    name      = "redis-ingress-policy"
    namespace = "ctfd"
  }

  spec {
    pod_selector {
      match_expressions {
        key      = "name"
        operator = "In"
        values   = ["redis"]
      }
    }

    ingress {
      ports {
        port     = "6379"
        protocol = "TCP"
      }

      from {
        pod_selector {
          match_labels = {
            name = "name"
            operator = "In"
            value = "ctfd"
          }
        }
      }
    }
    egress {} # single empty rule to allow all egress traffic
    policy_types = ["Ingress", "Egress"]
  } 
  depends_on = [kubernetes_namespace.ctfd]
}