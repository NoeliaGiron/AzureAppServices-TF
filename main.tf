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

  sku_name = "F1"
  os_type  = "Windows"
}

resource "azurerm_windows_web_app" "web_app" {
  name                = "webapp-${random_pet.name.id}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  app_service_plan_id = azurerm_service_plan.app_plan.id

  site_config {
    always_on = false
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
