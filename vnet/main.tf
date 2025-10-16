resource "azurerm_virtual_network" "practicevnet" {
  name                      = var.vnetname
  address_space             = ["10.10.0.0/16"]
  location                  = var.location
  resource_group_name       = var.resource_group_name

    tags = {
    environment = dev
  }
}

resource "azurerm_subnet" "practicesubnet" {
  name                 = var.subnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.practicevnet.name
  address_prefixes     = ["10.10.1.0/24"]
}