resource "azurerm_resource_group" "aksrg" {
    name        = var.rgname
    location    = var.location
    tags        = var.tags
    
}