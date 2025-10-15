module "storage" {
  source                   = "./storage"
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
}
