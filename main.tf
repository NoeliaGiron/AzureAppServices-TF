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

  sku {
    tier = "Free"
    size = "F1"
  }

  os_type = "Linux"
}

resource "azurerm_linux_web_app" "web_app" {
  name                = "neoliaapp${random_id.suffix.hex}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    linux_fx_version = "NODE|18-lts" # o el runtime que uses
    always_on       = false
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
