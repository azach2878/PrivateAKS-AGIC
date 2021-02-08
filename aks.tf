resource "azurerm_kubernetes_cluster" "aks" {
    name                    = var.aks_cluster_name
    location                = var.location
    dns_prefix              = var.dns_prefix
    resource_group_name     = azurerm_resource_group.aksrg.name
    tags                    = var.tags
    private_cluster_enabled = true
    depends_on              = [azurerm_route.internetTunneling]
    
    default_node_pool {
    name                    = "nodepool01"
    node_count              = 2
    vm_size                 = "Standard_D2s_v3"
    type                    = "VirtualMachineScaleSets"
    enable_auto_scaling     = true
    max_count               = 10
    min_count               = 2
    availability_zones      = ["1", "2", "3"]
    max_pods                = 100
    os_disk_size_gb         = 40
    vnet_subnet_id          = azurerm_subnet.kubesubnet.id
    enable_node_public_ip   = false 
    }

    role_based_access_control {
        enabled = true
    }
###########################################################
#                         NOTE                            #
# Configure Kubernetes role-based access control (RBAC) using Azure Active Directory group membership.
# This can be used to control access to specific namespaces inside your Kubernetes cluster based on a user's membership in specified Azure Active Directory groups.
# Note: Once this feature is enabled, it cannot be disabled.
# 
# AKS-managed Azure AD integration is designed to simplify the Azure AD integration experience
#  
# Cluster administrators can configure (Kubernetes RBAC) based on a user's identity or directory group membership. 
# Azure AD authentication is provided to AKS clusters with OpenID Connect. 
# OpenID Connect is an identity layer built on top of the OAuth 2.0 protocol. 
# For more information on OpenID Connect, see the Open ID connect documentation.
###########################################################
/* Uncomment if wanted to use this feature .... 
role_based_access_control {
    enabled = true

    azure_active_directory {
      managed = true
      admin_group_object_ids = [
        data.azuread_group.aks.id
      ]
    }
  }
*/
###########################
identity {
        type = "SystemAssigned"
    }

network_profile {
#   load_balancer_sku  = "standard"
    outbound_type      = "userDefinedRouting"
    network_plugin     = "azure"
    network_policy     = "calico" 
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.0.0/16"
  }
    addon_profile {
        
        oms_agent {
            enabled                     = true
            log_analytics_workspace_id  = local.omsID
        }
        azure_policy {
            enabled = true
        } 
    }

}
