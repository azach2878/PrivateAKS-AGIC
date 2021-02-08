# Add public IP address for APP Gateway
resource "azurerm_public_ip" "ip" {
  name                         = "GW-IP"
  location                     = azurerm_resource_group.aksrg.location
  resource_group_name          = azurerm_resource_group.aksrg.name
  allocation_method            = "Static"
  sku                          = "Standard"
  tags = var.tags
}
