locals {
  hubVnetID               = data.azurerm_virtual_network.hub_vnet.id
  omsID                   = data.azurerm_log_analytics_workspace.oms.id
  fw_privateip            = data.azurerm_firewall.fw.ip_configuration[0].private_ip_address
  acrID                   = data.azurerm_container_registry.acr.id
  } 

  
