
resource "helm_release" "mariadb" {
  name       = "maria-db"
  chart      = "mariadb"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = var.namespace
  values = [
    data.template_file.mariadb.rendered
  ]
  timeout = 1800
}

data "template_file" "mariadb" {
  template = file("${path.module}/mariadb.yaml")
  vars = {
    db_user  = var.db_user
    db_pwd   = var.db_password
    db_name  = var.db_name
    root_pwd = var.root_user_password
  }
}