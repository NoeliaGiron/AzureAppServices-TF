terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.38"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  # No es necesario poner aquí subscription_id, tenant_id, client_id, client_secret
  # porque Jenkins ya exporta esas variables de entorno y el provider las detecta automáticamente
}

resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "app_rg" {
  name     = "rg-${random_pet.name.id}"
  location = "East US"
}

resource "azurerm_service_plan" "app_plan" {
  name                = "plan-${random_pet.name.id}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  sku_name = "F1"      # Plan Free, puedes cambiar por S1, P1v2, etc.
  os_type  = "Windows" # Sistema operativo Windows
}

resource "azurerm_windows_web_app" "web_app" {
  name                = "webapp-${random_pet.name.id}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    always_on = false
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
