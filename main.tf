provider "azurerm" {
  version = "=2.0.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-hello-azure-tf"
    storage_account_name = "sakursazuretf"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

#Create Resource Group
resource "azurerm_resource_group" "rg-hello-azure" {
  name     = "rg-hello-azure"
  location = "NorthEurope"
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}
# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup-${random_integer.ri.result}"
  location = "NorthEurope"
}