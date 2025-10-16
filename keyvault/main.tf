
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
    bypass                     = "AzureServices"             # Optional: Allow trusted services

    # ✅ Allow access from AKS subnet
    virtual_network_subnet_ids = [
      azurerm_subnet.practicesubnet.id
    ]
}
