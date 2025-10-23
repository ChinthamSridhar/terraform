resource "azurerm_virtual_network" "practicevnet" {
  name                      = var.vnetname
  address_space             = ["10.10.0.0/16"]
  location                  = var.location
  resource_group_name       = var.resource_group_name

    tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "kvsubnet" {
  name                 = var.kvsubnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.practicevnet.name
  address_prefixes     = ["10.10.1.0/24"]

}

resource "azurerm_subnet" "akssubnet" {
  name                 = var.akssubnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.practicevnet.name
  address_prefixes     = ["10.10.2.0/24"]
}

resource "azurerm_subnet" "sasubnet" {
  name                 = var.sasubnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.practicevnet.name
  address_prefixes     = ["10.10.3.0/24"]
}

resource "azurerm_subnet" "acrsubnet" {
  name                 = var.acrsubnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.practicevnet.name
  address_prefixes     = ["10.10.4.0/24"]
}