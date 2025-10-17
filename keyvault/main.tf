
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get", "List"]
  }
  # 🔐 Network Rules
  network_acls {
    default_action             = "Deny"                      # Deny by default
    bypass                     = "None"             # Optional: Allow trusted services
}
  tags = {
    environment = "dev"
  }
}

data "azurerm_subnet" "kvsubnet" {
  name                 = "kvsubnet-practice-dev"
  virtual_network_name = "vnet-practice-dev"
  resource_group_name  = var.resource_group_name
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "kv-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.kvsubnet.id

  private_service_connection {
    name                           = "kv-privatesc"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

