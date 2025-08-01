variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
}

variable "client_id" {
  description = "Client ID del service principal"
  type        = string
}

variable "client_secret" {
  description = "Client secret del service principal"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Tenant ID de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-terraform-example"
}

variable "location" {
  description = "Ubicación para los recursos"
  type        = string
  default     = "East US"
}

variable "app_service_plan_name" {
  description = "Nombre del App Service Plan"
  type        = string
  default     = "plan-appservice-example"
}

variable "app_service_name" {
  description = "Nombre del App Service"
  type        = string
  default     = "appservice-example"
}
