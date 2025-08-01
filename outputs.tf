output "app_service_default_hostname" {
  description = "URL del App Service"
  value       = azurerm_windows_web_app.web_app.default_site_hostname
}
