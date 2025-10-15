module "storage" {
  source                   = "./storage"
  name                     = var.saname
  resource_group_name      = var.resource_group_name
  location                 = var.location
}