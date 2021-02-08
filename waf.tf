 resource "azurerm_application_gateway" "waf" {
  name                = "AKS-AppGateway-WAF2"
  resource_group_name = azurerm_resource_group.aksrg.name
  location            = azurerm_resource_group.aksrg.location
  enable_http2        = false
  zones               = ["1", "2", "3"]

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 4
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aksManagedUser.id]
  }

  # ssl_certificate {
  #  name                = azurerm_key_vault_certificate.cert1.name
  #  key_vault_secret_id = azurerm_key_vault_certificate.cert1.secret_id
  # }

  gateway_ip_configuration {
    name      = "GW-IP-cfg"
    subnet_id = azurerm_subnet.gw.id 
  }

  frontend_ip_configuration {
    name                  = "Frontend-Public-cfg"
    public_ip_address_id  = azurerm_public_ip.ip.id 
  }

  frontend_port {
    name = "Frontend-Port-80"
    port = 80
  }

  backend_address_pool {
    name = "Default-BE-Pool"
  }

  backend_http_settings {
    name                  = "Backend-Http"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "Http-Listener"
    frontend_ip_configuration_name = "Frontend-Public-cfg"
    frontend_port_name             = "Frontend-Port-80"
    protocol                       = "Http"
    #ssl_certificate_name           = azurerm_key_vault_certificate.cert1.name

  }

  request_routing_rule {
    name                       = "Http-RR-Rule"
    rule_type                  = "Basic"
    http_listener_name         = "Http-Listener"
    backend_address_pool_name  = "Default-BE-Pool"
    backend_http_settings_name = "Backend-Http"
  }
 # depends_on = [ azurerm_virtual_network.aksvnet]
}
