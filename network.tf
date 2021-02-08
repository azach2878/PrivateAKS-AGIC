resource "azurerm_virtual_network" "aksvnet" {
  tags                    = var.tags
  name                    = "AKS-aksvnet"
  location                = azurerm_resource_group.aksrg.location
  resource_group_name     = azurerm_resource_group.aksrg.name
  address_space           = ["192.172.0.0/16"]
}

resource "azurerm_subnet" "AKSsubnet" {
  name                    = "kube-Subnet"
  resource_group_name     = azurerm_resource_group.aksrg.name
  virtual_network_name    = azurerm_virtual_network.aksvnet.name
  address_prefixes        = ["192.172.1.0/24"]
}

resource "azurerm_subnet" "gw" {
  name                    = "appgw"
  resource_group_name     = azurerm_resource_group.aksrg.name
  virtual_network_name    = azurerm_virtual_network.aksvnet.name
  address_prefixes        = ["192.172.2.0/27"]
}

