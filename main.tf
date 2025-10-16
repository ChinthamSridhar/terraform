module "storage" {
  source                   = "./storage"
  name                     = var.saname
  resource_group_name      = var.resource_group_name
  location                 = var.location
}

module "vnet" {
  source                   = "./vnet"
  resource_group_name      = var.resource_group_name
  location                 = var.location
}