data "azurerm_virtual_network" "hub_vnet" {
  name                          = var.hub_vnet
  resource_group_name           = var.hub_rg
}

data "azurerm_log_analytics_workspace" "oms" {
    name                        = var.oms_name
    resource_group_name         = var.oms_rg
}

data "azurerm_firewall" "fw" {
    name                        = var.fw_name
    resource_group_name         = var.fw_rg
}

data "azurerm_monitor_diagnostic_categories" "aks" {
    resource_id                 = azurerm_kubernetes_cluster.aks.id
}

data "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.acr_rg
}