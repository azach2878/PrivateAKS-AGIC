
resource "azurerm_user_assigned_identity" "aksManagedUser" {
    name                = "ManagedUserAKS"
    resource_group_name = azurerm_resource_group.aksrg.name
    location            = azurerm_resource_group.aksrg.location
    tags                = var.tags
}

