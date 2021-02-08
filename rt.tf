resource "azurerm_route_table" "rt" {
    name                          = "AKS-GW-RT"
    location                      = azurerm_resource_group.aksrg.location
    resource_group_name           = azurerm_resource_group.aksrg.name
    disable_bgp_route_propagation = "true"
    tags                          = var.tags
}

resource "azurerm_subnet_route_table_association" "rtsubnet" {
    subnet_id                     = azurerm_subnet.AKSsubnet.id
    route_table_id                = azurerm_route_table.rt.id
    
    depends_on = [azurerm_virtual_network.aksvnet]
}

resource "azurerm_route" "internetTunneling" {
    name                           = "Egress-Traffic"
    resource_group_name            = azurerm_resource_group.aksrg.name
    route_table_name               = azurerm_route_table.rt.name
    address_prefix                 = "0.0.0.0/0"
    next_hop_type                  = "VirtualAppliance"
    next_hop_in_ip_address         = local.fw_privateip
}
