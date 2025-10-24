resource "azurerm_container_registry" "acrpracticedev" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
}

data "azurerm_subnet" "acrsubnet" {
  name                 = "acrsubnet-practice-dev"
  virtual_network_name = "vnet-practice-dev"
  resource_group_name  = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                 = "vnet-practice-dev"
  resource_group_name  = var.resource_group_name
}

# Private Endpoint for ACR
resource "azurerm_private_endpoint" "acr_pe" {
  name                = "acr-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.acrsubnet.id

  private_service_connection {
    name                           = "acr-privatesc"
    private_connection_resource_id = azurerm_container_registry.acrpracticedev.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }
}

# Private DNS Zone for ACR
resource "azurerm_private_dns_zone" "acr_dns" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
}

# DNS Zone link to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
  name                  = "acr-dns-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_dns.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled  = false
}
