resource "azurerm_storage_account" "storage" {
  name                     = var.name # must be globally unique
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "practicestate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
