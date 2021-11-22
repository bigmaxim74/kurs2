#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "kurs-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "NorthEurope"
  resource_group_name = "rg-hello-azure-tf"
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = "rg-hello-azure-tf"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}