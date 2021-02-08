
resource "azurerm_log_analytics_solution" "aks-containerinsights" {
  solution_name         = "ContainerInsights"
  location              = var.oms_location
  resource_group_name   = var.oms_rg
  workspace_resource_id = local.omsID
  workspace_name        = var.oms_name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

  resource "azurerm_monitor_diagnostic_setting" "aks" {
    name                       = format("%s-aks-audit","Diagnostics-aks")
    target_resource_id         = azurerm_kubernetes_cluster.aks.id
    log_analytics_workspace_id = local.omsID

  dynamic "log" {
    iterator = log_category
    for_each = data.azurerm_monitor_diagnostic_categories.aks.logs

    content {
        category = log_category.value
        enabled  = true

    retention_policy {
        enabled = true
        days    = "15"
        }
     }
    }
    dynamic "metric" {
    iterator = metric_category
    for_each = data.azurerm_monitor_diagnostic_categories.aks.metrics

    content {
        category = metric_category.value
        enabled  = true

      retention_policy {
        enabled = true
        days    = "15"
      }
    }
  }
}