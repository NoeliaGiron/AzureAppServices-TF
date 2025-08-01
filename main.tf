provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resource-group"
  location = "East US"
}

resource "azurerm_service_plan" "app_plan" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_linux_web_app" "web_app" {
  name                = "example-linux-web-app-${random_integer.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    application_stack {
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
  }
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}
