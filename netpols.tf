/*
# networking/use-netpols: "false"
resource "kubernetes_network_policy" "default" {
  metadata {
    name      = "default-allow-all-netpol"
    namespace = var.namespace
  }

  spec {
    pod_selector {
      match_expressions {
        key      = "networking/use-netpols"
        operator = "NotIn"
        values   = ["true"]
      }
    }

    egress {} # allow everything
    policy_types = ["Egress"]
  }
}

# networking/use-netpols: "true"
resource "kubernetes_network_policy" "default_deny_egress" {
  metadata {
    name      = "default-deny-egress-netpol"
    namespace = var.namespace
  }
  # 0.0.0.0/0 Open for all in two cidrs
  spec {
    pod_selector {
      match_expressions {
        key      = "networking/use-netpols"
        operator = "In"
        values   = ["true"]
      }
    }
    egress {
      to {
        namespace_selector {
          match_labels = {
            name = "monitoring"
          }
        }
        pod_selector {
          match_expressions {
            key      = "app"
            operator = "In"
            values   = ["prometheus"]
          }
        }
      }
    }
    policy_types = ["Egress"]
  }
}

# networking/allow-dns: "true"
resource "kubernetes_network_policy" "allow_dns_traffic" {
  metadata {
    name      = "default-deny-egress-netpol"
    namespace = var.namespace
  }
  # 0.0.0.0/0 Open for all in two cidrs
  spec {
    pod_selector {
      match_expressions {
        key      = "networking/allow-dns"
        operator = "In"
        values   = ["true"]
      }
    }
    egress {
      to {
        namespace_selector {
          match_labels = {
            name = "kube-system"
          }
        }
        pod_selector {
          match_expressions {
            key      = "k8s-app"
            operator = "In"
            values   = ["kube-dns"]
          }
        }
      }
    }
    policy_types = ["Egress"]
  }
}

resource "kubernetes_network_policy" "mariadb" {
  metadata {
    name      = "allow-egress-to-mariadb"
    namespace = var.namespace
  }
  # 0.0.0.0/0 Open for all in two cidrs
  spec {
    pod_selector {
      match_expressions {
        key      = "networking/allow-mariadb"
        operator = "In"
        values   = ["true"]
      }
    }
    egress {
      to {
        namespace_selector {
          match_labels = {
            name = "monitoring"
          }
        }
        pod_selector {
          match_expressions {
            key      = "app"
            operator = "In"
            values   = ["prometheus"]
          }
        }
      }
    }
    policy_types = ["Egress"]
  }
}
resource "kubernetes_network_policy" "redis" {
  metadata {
    name      = "allow-egress-to-mariadb"
    namespace = var.namespace
  }
  # 0.0.0.0/0 Open for all in two cidrs
  spec {
    pod_selector {
      match_expressions {
        key      = "networking/allow-mariadb"
        operator = "In"
        values   = ["true"]
      }
    }
    egress {
      to {
        namespace_selector {
          match_labels = {
            name = "monitoring"
          }
        }
        pod_selector {
          match_expressions {
            key      = "app"
            operator = "In"
            values   = ["prometheus"]
          }
        }
      }
    }
    policy_types = ["Egress"]
  }
}
resource "kubernetes_network_policy" "ctfd" {
  metadata {
    name      = "allow-egress-to-mariadb"
    namespace = var.namespace
  }
  # 0.0.0.0/0 Open for all in two cidrs
  spec {
    pod_selector {
      match_expressions {
        key      = "networking/allow-mariadb"
        operator = "In"
        values   = ["true"]
      }
    }
    egress {
      to {
        namespace_selector {
          match_labels = {
            name = "monitoring"
          }
        }
        pod_selector {
          match_expressions {
            key      = "app"
            operator = "In"
            values   = ["prometheus"]
          }
        }
      }
    }
    policy_types = ["Egress"]
  }
}

*/