resource "azurerm_storage_account" "storage" {
  name                     = var.name # must be globally unique
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
  default_action             = "Deny"
  bypass                     = ["AzureServices"]
  virtual_network_subnet_ids = [data.azurerm_subnet.sasubnet.id]
}

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "practicestate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

data "azurerm_subnet" "sasubnet" {
  name                 = "sasubnet-practice-dev"
  virtual_network_name = "vnet-practice-dev"
  resource_group_name  = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                 = "vnet-practice-dev"
  resource_group_name  = var.resource_group_name
}

resource "azurerm_private_endpoint" "sa_pe" {
  name                = "sa-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.sasubnet.id

  private_service_connection {
    name                           = "kv-privatesc"
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
resource "azurerm_private_dns_zone" "sa_dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "sa-dns-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sa_dns.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled  = false
}
