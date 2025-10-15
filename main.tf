module "storage" {
  source                   = "./storage"
  name                     = var.saname
  client_id                = var.client_id
  client_secret            = var.client_secret
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  resource_group_name      = var.resource_group_name
  location                 = var.location
}
