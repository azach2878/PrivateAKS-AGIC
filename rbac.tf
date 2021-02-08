resource "azurerm_role_assignment" "rbac1" {
    scope                               = azurerm_container_registry.acr.id
    role_definition_name                = "AcrPull"
    principal_id                        = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
    skip_service_principal_aad_check    = true
}

resource "azurerm_role_assignment" "rbac2" {
    scope                               = azurerm_virtual_network.aksvnet.id
    role_definition_name                = "Network Contributor"
    principal_id                        = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}

resource "azurerm_role_assignment" "rbac3" {
    scope                               = azurerm_user_assigned_identity.aksManagedUser.id
    role_definition_name                = "Managed Identity Operator"
    principal_id                        = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}


resource "azurerm_role_assignment" "rbac4" {
    scope                               = azurerm_application_gateway.waf.id
    role_definition_name                = "Contributor"
    principal_id                        = azurerm_user_assigned_identity.aksManagedUser.principal_id
}

resource "azurerm_role_assignment" "rbac5" {
    scope                               = azurerm_resource_group.aksrg.id
    role_definition_name                = "Reader"
    principal_id                        = azurerm_user_assigned_identity.aksManagedUser.principal_id
}

/*
resource "azurerm_role_assignment" "rbac6" {
    scope                               = data.azurerm_resource_group.kvrg.id
    role_definition_name                = "Contributor"
    principal_id                        = azurerm_user_assigned_identity.aksManagedUser.principal_id
}

*/






# If you have an ACR already created, you can reference it here 
# data.azurerm_container_registry.acr.id
# "${data.azurerm_subscription.current.id}/resourceGroups/${var.rg}"