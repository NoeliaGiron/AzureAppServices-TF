provider "azurerm" {
  features {}
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_resource_group" "app_rg" {
  name     = "rg-tf-appservice"
  location = "East US"
}

resource "azurerm_service_plan" "app_plan" {
  name                = "appservice-plan"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  sku_name = "F1"
  sku_tier = "Free"

  os_type = "Linux"
}

resource "azurerm_linux_web_app" "web_app" {
  name                = "neoliaapp${random_id.suffix.hex}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    linux_fx_version = "NODE|18-lts"
    always_on       = false
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

output "app_service_url" {
  value = azurerm_linux_web_app.web_app.default_site_hostname
}
