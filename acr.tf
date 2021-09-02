


resource "azurerm_container_registry" "acr" {
  name                     = var.container_registry_name
  resource_group_name      = azurerm_resource_group.aksrg.name
  location                 = var.location
  sku                      = "Standard" # If planning to use Private Endpoint then have to use #"Premium" SKU 
  admin_enabled            = false
}


