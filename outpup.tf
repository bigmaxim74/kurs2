
output "website_url" {
  value = azurerm_app_service.rg.default_site_hostname
}