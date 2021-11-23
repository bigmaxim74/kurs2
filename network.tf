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

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = "NorthEurope"
    resource_group_name          = "rg-hello-azure-tf"
    allocation_method            = "Dynamic"

}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "myNetworkSecurityGroup"
    location            = "NorthEurope"
    resource_group_name = "rg-hello-azure-tf"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }


}

# Create network interface
resource "azurerm_network_interface" "m2terraformnic" {
    name                      = "myNIC"
    location                  = "NorthEurope"
    resource_group_name       = "rg-hello-azure-tf"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "azurerm_subnet.subnet.id"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "kursach" {
    network_interface_id      = azurerm_network_interface.m2terraformnic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

