terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.38.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
  }
}

provider "azurerm" {
  features {}
}

# Generar nombre aleatorio para el resource group
resource "random_pet" "rg_name" {
  length    = 2
  separator = "-"
}

# Crear el Resource Group en Azure
resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = "East US"
}
