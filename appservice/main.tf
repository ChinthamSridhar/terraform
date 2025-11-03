resource "azurerm_service_plan" "appserviceplan" {
  name                = var.aspname
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "P1v2"

 tags = {
    environment = "dev"
  }
}

resource "azurerm_linux_web_app" "webapp" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  https_only            = true
  site_config {
    minimum_tls_version = "1.2"
  }

    tags = {
    environment = "dev"
  }
}
