# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "webapp-asp-${random_integer.rg-hello-azure-tf.result}"
  location            = azurerm_resource_group.rg-hello-azure-tf.location
  resource_group_name = azurerm_resource_group.rg-hello-azure-tf.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = "webapp-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg-hello-azure-tf.location
  resource_group_name = azurerm_resource_group.rg-hello-azure-tf.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  source_control {
    repo_url           = "https://github.com/bigmaxim74/testkurs1"
    branch             = "main"
  }

  site_config {
    linux_fx_version = "PHP|7.0"
    scm_type         = "LocalGit"
  }
}