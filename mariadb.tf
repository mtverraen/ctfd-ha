module "mariadb" {
  source             = "./modules/mariadb"
  namespace          = kubernetes_namespace.ctfd.metadata.0.name
  db_name            = "ctfd"
  db_user            = "ctfd"
  db_password        = random_string.maria_db_password.result
  root_user_password = random_string.maria_root_db_password.result #ctfd uses this natively

}

resource "random_string" "maria_root_db_password" {
  length           = 32
  special          = false
  override_special = "/@£$"
}
resource "random_string" "maria_db_password" {
  length           = 32
  special          = false
  override_special = "/@£$"
}
