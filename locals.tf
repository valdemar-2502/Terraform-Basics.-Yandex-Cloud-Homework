locals {
  # Используем несколько переменных для создания имён
  project_prefix = "netology"
  env            = var.vpc_name
  
  web_name = "${local.project_prefix}-${local.env}-platform-web"
  db_name  = "${local.project_prefix}-${local.env}-platform-db"
}
