# Peering 
resource "azurerm_virtual_network_peering" "spoke1-hub-peer" {
  name                              = "aks-hub-peer"
  resource_group_name               = azurerm_resource_group.aksrg.name
  virtual_network_name              = azurerm_virtual_network.aksvnet.name
  remote_virtual_network_id         = local.hubVnetID

  allow_virtual_network_access      = true
  allow_forwarded_traffic           = true
  allow_gateway_transit             = false
  use_remote_gateways               = false
  depends_on = [azurerm_virtual_network.aksvnet]
}

resource "azurerm_virtual_network_peering" "hub-spoke1-peer" {
  name                              = "hub-aks-peer"
  resource_group_name               = var.hub_rg
  virtual_network_name              = var.hub_vnet
  remote_virtual_network_id         = azurerm_virtual_network.aksvnet.id
}
