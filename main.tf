module "storage" {
  source                   = "./storage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
}

module "vnet" {
  source                   = "./vnet"
  resource_group_name      = var.resource_group_name
  location                 = var.location
}

module "keyvault" {
  source                   = "./keyvault"
  resource_group_name      = var.resource_group_name
  location                 = var.location
}